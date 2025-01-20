import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

late List<CameraDescription> cameras;

Future<void> loadCameras() async {
  try {
    cameras = await availableCameras();
  } catch (e) {
    debugPrint(e.toString());
  }
}
