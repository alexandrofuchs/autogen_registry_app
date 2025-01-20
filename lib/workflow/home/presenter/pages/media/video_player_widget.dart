import 'dart:io';
import 'package:flutter/material.dart';
import 'package:plain_registry_app/core/helpers/formatters/duration_formatter.dart';
import 'package:plain_registry_app/core/theme/app_colors.dart';
import 'package:plain_registry_app/core/theme/app_text_styles.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final File file;

  const VideoPlayerWidget({super.key, required this.file});

  @override
  State<VideoPlayerWidget> createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  bool isReady = false;

  @override
  void initState() {
    super.initState();
    initController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void remount(){
    if(_controller.value.isInitialized){
      _controller.removeListener(remount);
      setState(() {
        isReady = true;
      });
    }
  }

  void initController() {
    _controller = VideoPlayerController.file(widget.file);
    _controller.setLooping(true);
    _controller.addListener(remount);
    _controller.initialize();
  }

  bool isLandscape(BuildContext context) =>
    _controller.value.size.width > _controller.value.size.height;

  mid(Function setState) => Container(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            SizedBox(
              child: IconButton(
                icon: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: AppColors.backgroundColor,
                  size: 70,
                ),
                onPressed: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
              ),
            ),
            const SizedBox()
          ],
        ),
      );

  bottom(Function setState) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: ValueListenableBuilder(
                  valueListenable: _controller,
                  builder: (context, value, _) {
                    return Text(
                      value.position.formatTime(),
                      style: AppTextStyles.bodyStyleSmall,
                    );
                  },
                )),
            Flexible(
              child: VideoProgressIndicator(
                _controller,
                allowScrubbing: true,
                colors: const VideoProgressColors(
                    backgroundColor: AppColors.backgroundColor,
                    bufferedColor: AppColors.primaryColorLight,
                    playedColor: AppColors.primaryColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _controller.value.duration.formatTime(),
                style: const TextStyle(color: AppColors.backgroundColor),
              ),
            ),
          ],
        ),
      );

  Widget visiblePlayerOverlay(Function setState) => Container(
        color: _controller.value.isPlaying
            ? Colors.transparent
            : Colors.black.withOpacity(0.3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 30,),
            mid(setState),
            bottom(setState),
          ],
        ),
      );

  Widget invisiblePlayerOverlay(Function setState) => Stack(
        children: [
          Container(
            color: Colors.transparent,
            alignment: Alignment.center,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [const SizedBox(), const SizedBox(), bottom(setState)],
          ),
          Center(
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
                child: Container(
                  height: 100,
                  width: 100,
                  color: Colors.transparent,
                )),
          ),
        ],
      );

  Widget _normalBuild(Function setState) => AnimatedCrossFade(
        layoutBuilder: (topChild, topChildKey, bottomChild, bottomChildKey) {
          return Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                key: bottomChildKey,
                child: bottomChild,
              ),
              Positioned(
                key: topChildKey,
                child: topChild,
              ),
            ],
          );
        },
        duration: const Duration(milliseconds: 500),
        reverseDuration: const Duration(milliseconds: 500),
        excludeBottomFocus: true,
        firstChild: visiblePlayerOverlay(setState),
        firstCurve: Curves.bounceInOut,
        secondChild: invisiblePlayerOverlay(setState),
        sizeCurve: Curves.linearToEaseOut,
        alignment: Alignment.center,
        crossFadeState: !_controller.value.isPlaying
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
      );

  initializedBuild(BuildContext context, Function setState) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AspectRatio(
            aspectRatio: 1,
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ))),
        _normalBuild(setState)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return !isReady ? const SizedBox() : initializedBuild(context, setState);
  }
}
