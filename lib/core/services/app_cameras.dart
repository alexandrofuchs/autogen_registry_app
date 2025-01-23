import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class AppCameras {
  AppCameras._privateConstructor();

  static final AppCameras _instance = AppCameras._privateConstructor();

  late List<CameraDescription> cameras;

  static AppCameras get instance => _instance;

  Future<void> loadCameras() async {
    try {
      cameras = await availableCameras();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
