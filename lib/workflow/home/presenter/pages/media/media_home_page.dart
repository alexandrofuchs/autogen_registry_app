import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:plain_registry_app/core/theme/app_colors.dart';
import 'package:plain_registry_app/core/theme/app_gradients.dart';
import 'package:plain_registry_app/core/theme/app_text_styles.dart';
import 'package:plain_registry_app/core/widgets/appbar/appbar_widgets.dart';
import 'package:plain_registry_app/core/widgets/common/common_widgets.dart';
import 'package:plain_registry_app/workflow/home/domain/models/loaded_file.dart';
import 'package:plain_registry_app/workflow/home/domain/models/registry_model.dart';
import 'package:plain_registry_app/workflow/home/presenter/pages/media/camera_widget.dart';
import 'package:plain_registry_app/workflow/home/presenter/pages/media/media_picker.dart';
import 'package:plain_registry_app/root/app_router.dart';

class MediaHomePage extends StatefulWidget {
  final RegistryModel model;
  final MediaType mediaType;
  const MediaHomePage({super.key, required this.model, required this.mediaType});

  @override
  State<StatefulWidget> createState() => _MediaHomeState();
}

class _MediaHomeState extends State<MediaHomePage>
    with MediaPicker, AppbarWidgets, CommonWidgets {
  late final ValueNotifier<LoadedFile?> _loadedFile;

  @override
  initState() {
    _loadedFile = ValueNotifier(null);
    super.initState();
  }

  @override
  dispose() {
    _loadedFile.dispose();
    super.dispose();
  }

  void sendMedia(LoadedFile file) {
    late RegistryType itemType;
    switch (file.mediaType) {
      case MediaType.image:
        itemType = RegistryType.image;
        break;
      case MediaType.video:
        itemType = RegistryType.video;
        break;
    }
  }

  Widget header() => Container(
        height: 100,
        decoration: const BoxDecoration(gradient: AppGradients.primaryColors),
      );

  Widget title() => const Text(
        'Pick you File',
        textAlign: TextAlign.center,
        style: AppTextStyles.titleStyleLarge,
      ).animate().scaleXY(
          begin: 0, end: 1, duration: const Duration(milliseconds: 1000));

  Widget button(IconData icon, String label, Function() action) => Container(
        decoration: BoxDecoration(
            color: AppColors.secundaryColor,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: AppColors.primaryColor, width: 2)),
        child: Column(
          children: [
            IconButton(
                onPressed: action,
                icon: Icon(
                  icon,
                  size: 90,
                )),
            Text(
              label,
              style: AppTextStyles.titleStyleMedium,
            )
          ],
        ),
      )..animate(
          delay: const Duration(milliseconds: 2000),
          onPlay: (controller) => controller.repeat(),
        ).shake();

  infoRow(String label, String text) => Align(
        alignment: Alignment.bottomLeft,
        child: RichText(
          textAlign: TextAlign.start,
          text: TextSpan(style: AppTextStyles.titleStyleMedium, children: [
            TextSpan(
                text: '$label: ',
                style: AppTextStyles.titleStyleMedium
                    .copyWith(fontWeight: FontWeight.w600)),
            TextSpan(text: text),
          ]),
        ),
      );

  Widget itemInfos() => Padding(
        padding: const EdgeInsets.all(25),
        child: Column(children: [
          infoRow('grupo', widget.model.group),
          infoRow('descrição', widget.model.description),
          infoRow('nome do arquivo', widget.model.filename),
          infoRow('tipo do arquivo', widget.model.type.toString()),
        ]),
      );

  Widget loadMediaActions() =>
    Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                actionButton(Icons.camera, 'Camera', () async {
                  final file = await Navigator.of(context).push<LoadedFile>(
                      AppRouter.createRoute<LoadedFile>(const CameraWidget()));
                  if (file == null) return;
                  _loadedFile.value = file;
                  // sendMedia(file);
                }),
                actionButton(Icons.library_add, 'Galeria', () async {
                  final file = await pickMedia(context);
                  if (file == null) return;
                  _loadedFile.value = file;
                  // sendMedia(file);
                }),
              ],
            );


  Widget loadedFileWidget(LoadedFile file) =>
    Stack(alignment: Alignment.topRight, children: [
              AspectRatio(
                aspectRatio: 1.5,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: const [
                          BoxShadow(
                              spreadRadius: 0,
                              blurRadius: 1,
                              offset: Offset(0, 1))
                        ]),
                    padding: const EdgeInsets.all(1),
                    margin: const EdgeInsets.all(10),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.file(file.file)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: IconButton(
                    onPressed: () {
                      _loadedFile.value = null;
                    },
                    icon: const Icon(
                      Icons.close_outlined,
                      color: AppColors.primaryColorDark,
                      size: 24,
                    )),
              )
            ]);

  Widget loadedFileBuilder() => ValueListenableBuilder(
      valueListenable: _loadedFile,
      builder: (context, value, child) => _loadedFile.value == null
          ? loadMediaActions()
          : loadedFileWidget(value!));

  Widget midContent() =>
    Expanded(
                  child: ListView(
                    children: [
                    itemInfos(),
                    loadedFileBuilder(),
                  ]),
                );

  Widget bottomActions() =>
    Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      negativeActionButton('Cancelar', () {
                        Navigator.pop(context);
                      }),
                      positiveActionButton('Confirmar', () {}),
                    ],
                  ),
                );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 10,
        ),
        body: Container(
          decoration: const BoxDecoration(gradient: AppGradients.primaryColors),
          child: Column(
            children: [
              const Text('Criar arquivo', style: AppTextStyles.labelStyleLarge,),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  margin: const EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      midContent(),
                      bottomActions(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
