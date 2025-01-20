import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:plain_registry_app/core/helpers/extensions/list_extension.dart';
import 'package:plain_registry_app/core/services/load_cameras.dart';
import 'package:plain_registry_app/core/theme/app_colors.dart';
import 'package:plain_registry_app/core/widgets/common/common_widgets.dart';
import 'package:plain_registry_app/workflow/home/domain/models/loaded_file.dart';
import 'package:plain_registry_app/workflow/home/presenter/pages/media/video_player_widget.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class CameraWidget extends StatefulWidget {
  const CameraWidget({super.key});

  @override
  State<StatefulWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> with CommonWidgets {
  late CameraController controller;

  XFile? imageFile;
  XFile? videoFile;

  bool isReady = false;
  ValueNotifier<bool> isBackCamera = ValueNotifier(false);
  int _pointers = 0;

  double minAvailableExposureOffset = 0.0;
  double maxAvailableExposureOffset = 0.0;

  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 2.0;
  final ValueNotifier<double> _currentScale = ValueNotifier(1.0);
  double _baseScale = 1.0;

  ValueNotifier<double> tickValue = ValueNotifier(0);

  Timer? timer;

  final maxTimeSeconds = 60;

  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();

    onInit();
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    controller.dispose();
    tickValue.dispose();
    isBackCamera.dispose();
    timer?.cancel();
    super.dispose();
  }

  void onInit() async {
    try {
      await Permission.camera.request();
      controller = CameraController(cameras[0], ResolutionPreset.max);
      await controller.initialize();

      await Future.wait(<Future<Object?>>[
        ...!kIsWeb
            ? <Future<Object?>>[
                controller
                    .getMinExposureOffset()
                    .then((double value) => minAvailableExposureOffset = value),
                controller
                    .getMaxExposureOffset()
                    .then((double value) => maxAvailableExposureOffset = value)
              ]
            : <Future<Object?>>[],
        controller
            .getMaxZoomLevel()
            .then((double value) => _maxAvailableZoom = value),
        controller
            .getMinZoomLevel()
            .then((double value) => _minAvailableZoom = value),
      ]);

      isBackCamera.value = cameras[0].lensDirection == CameraLensDirection.back;

      setState(() {
        isReady = true;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> startVideoRecording() async {
    if (!controller.value.isInitialized) {
      return;
    }

    if (controller.value.isRecordingVideo) {
      return;
    }

    try {
      await controller.startVideoRecording();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> onNewCameraSelected(CameraDescription cameraDescription) async {
    controller.setDescription(cameraDescription);
    isBackCamera.value =
        cameraDescription.lensDirection == CameraLensDirection.back;
  }

  Future<XFile?> stopVideoRecording() async {
    if (!controller.value.isRecordingVideo) {
      return null;
    }

    try {
      return controller.stopVideoRecording();
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  void onVideoRecordButtonPressed() async {
    await startVideoRecording();
    if (mounted) {
      setState(() {});
    }
  }

  void onStopButtonPressed() async {
    final file = await stopVideoRecording();
    if (mounted && file != null) {
      setState(() {
        videoFile = file;
      });
    }
  }

  void _handleScaleStart(ScaleStartDetails details) {
    _baseScale = _currentScale.value;
  }

  Future<void> _handleScaleUpdate(ScaleUpdateDetails details) async {
    if (_pointers != 2) {
      return;
    }

    _currentScale.value = (_baseScale * details.scale)
        .clamp(_minAvailableZoom, _maxAvailableZoom);

    await controller.setZoomLevel(_currentScale.value);
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    final CameraController cameraController = controller;

    final Offset offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    cameraController.setExposurePoint(offset);
    cameraController.setFocusPoint(offset);
  }

  Widget mediaView() => Container(
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      color: AppColors.primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          videoFile != null
              ? Flexible(child: VideoPlayerWidget(file: File(videoFile!.path)))
              : imageFile != null
                  ? Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2)),
                      child: Image.file(
                        File(imageFile!.path),
                        fit: BoxFit.fitHeight,
                      ))
                  : const SizedBox(),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.red,
                    border: Border.all(color: Colors.white),
                  ),
                  child: IconButton(
                      onPressed: () {
                        tickValue.value = 0;

                        setState(() {
                          imageFile = null;
                          videoFile = null;
                        });
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 32,
                        color: Colors.white,
                      )),
                ),
              ),
              Flexible(
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.white),
                      ),
                      child: IconButton(
                          onPressed: () {
                            LoadedFile? file;
                            if (imageFile != null) {
                              file = LoadedFile(
                                  File(imageFile!.path), MediaType.image);
                            } else if (videoFile != null) {
                              file = LoadedFile(
                                  File(videoFile!.path), MediaType.video);
                            }
                            Navigator.pop(context, file);
                          },
                          icon: const Icon(
                            Icons.check,
                            size: 32,
                            color: Colors.white,
                          ))))
            ],
          )
        ],
      ));

  Widget recordButton() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ValueListenableBuilder(
            valueListenable: tickValue,
            builder: (context, value, child) => Text(
              '${((maxTimeSeconds * value) / 1.0).toInt()}/60 seg.',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          GestureDetector(
            onTap: () async {
              final file = await controller.takePicture();
              imageFile = file;
            },
            onLongPressStart: (d) {
              onVideoRecordButtonPressed();
              timer = Timer.periodic(const Duration(seconds: 1), (timer) {
                final x = (timer.tick * 1.0) / maxTimeSeconds;
                tickValue.value = x;
                if (timer.tick >= maxTimeSeconds) {
                  timer.cancel();
                  onStopButtonPressed();
                }
              });
            },
            onLongPressEnd: (d) {
              timer?.cancel();
              onStopButtonPressed();
            },
            child: Stack(
              children: [
                const Icon(Icons.circle, color: Colors.red, size: 125),
                recordWidget(),
              ],
            ),
          ),
        ],
      );

  Widget recordWidget() => ValueListenableBuilder(
      valueListenable: tickValue,
      builder: (context, value, snapshot) => SizedBox.square(
          dimension: 125,
          child: CircularProgressIndicator(
            value: value,
            color: Colors.red,
            strokeWidth: 2.0,
            backgroundColor: Colors.white,
          )));

  Widget cameraActions() => Column(
        children: [
          const Expanded(child: SizedBox()),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.black.withOpacity(0.5),
            ),
            alignment: Alignment.center,
            height: 35,
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(2),
            width: 70,
            child: ValueListenableBuilder(
                valueListenable: _currentScale,
                builder: (context, value, child) => Text(
                      '${value.toStringAsFixed(1)}x',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                    )),
          ),
          Container(
            constraints: const BoxConstraints(maxHeight: 300),
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: IconButton(
                      onPressed: () {
                        late CameraDescription? camera;
                        if (isBackCamera.value) {
                          camera = cameras.firstWhereOrNull((e) =>
                              e.lensDirection == CameraLensDirection.front);
                        } else {
                          camera = cameras.firstWhereOrNull((e) =>
                              e.lensDirection == CameraLensDirection.back);
                        }

                        if (camera == null) return;
                        onNewCameraSelected(camera);
                      },
                      icon: ValueListenableBuilder(
                          valueListenable: isBackCamera,
                          builder: (context, value, child) => Icon(
                                value ? Icons.camera_front : Icons.camera_rear,
                                color: Colors.white,
                                size: 60,
                              ))),
                ),
                Expanded(child: recordButton()),
                const SizedBox(
                  width: 60,
                  height: 60,
                ),
              ],
            ),
          ),
        ],
      );

  Widget cameraView() =>
      Stack(fit: StackFit.expand, alignment: Alignment.bottomCenter, children: [
        Listener(
            onPointerDown: (_) => _pointers++,
            onPointerUp: (_) => _pointers--,
            child: CameraPreview(controller, child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onScaleStart: _handleScaleStart,
                onScaleUpdate: _handleScaleUpdate,
                onTapDown: (TapDownDetails details) =>
                    onViewFinderTap(details, constraints),
              );
            }))),
        cameraActions(),
      ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: const Text('Câmera'),
        ),
        body: isReady
            ? ValueListenableBuilder(
                valueListenable: controller,
                builder: (context, value, widget) => value.isInitialized
                    ? imageFile != null || videoFile != null
                        ? mediaView()
                        : cameraView()
                    : const SizedBox())
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}
