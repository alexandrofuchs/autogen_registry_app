import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:plain_registry_app/core/theme/app_colors.dart';
import 'package:plain_registry_app/core/theme/app_text_styles.dart';
import 'package:plain_registry_app/core/widgets/appbar/appbar_widgets.dart';
import 'package:plain_registry_app/workflow/home/domain/models/loaded_file.dart';
import 'package:plain_registry_app/workflow/home/domain/models/registry_model.dart';
import 'package:plain_registry_app/workflow/home/presenter/pages/media/camera_widget.dart';
import 'package:plain_registry_app/workflow/home/presenter/pages/media/media_picker.dart';
import 'package:plain_registry_app/workflow/root/app_router.dart';

class MediaHomePage extends StatefulWidget {
  final RegistryModel model;
  const MediaHomePage({super.key, required this.model});

  @override
  State<StatefulWidget> createState() => _MediaHomeState();
}

class _MediaHomeState extends State<MediaHomePage>
    with MediaPicker, AppbarWidgets {
  @override
  initState() {
    super.initState();
  }

  @override
  dispose() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 100,
          decoration: const BoxDecoration(
              gradient: AppGradients.primaryColors,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Pick you File',
              textAlign: TextAlign.center,
              style: AppTextStyles.titleStyleLarge,
            ).animate().scaleXY(
                begin: 0, end: 1, duration: const Duration(milliseconds: 1000)),
            const SizedBox(
              height: 15,
            ).animate().scaleXY(begin: 0, end: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button(Icons.camera, 'Camera', () async {
                  final file = await Navigator.of(context)
                      .push(AppRouter.createRoute(const CameraWidget()));
                  if (file == null) return;
                  sendMedia(file);
                }),
                button(Icons.library_add, 'Galeria', () async {
                  final file = await pickMedia(context);
                  if (file == null) return;
                  sendMedia(file);
                }),
              ],
            ),
          ],
        ),
        const SizedBox()
      ],
    ));
  }
}
