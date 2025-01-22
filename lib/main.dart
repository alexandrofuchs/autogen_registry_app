import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:plain_registry_app/core/services/load_cameras.dart';
import 'package:plain_registry_app/workflow/home/home_worflow.dart';
import 'package:plain_registry_app/root/app_entry.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Animate.restartOnHotReload = true;

  await Future.wait([loadCameras()]);

  HomeWorflow.register();
  runApp(const AppEntry());
}
