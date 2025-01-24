import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:plain_registry_app/core/external/gemini_api.dart';
import 'package:plain_registry_app/core/services/app_cameras.dart';
import 'package:plain_registry_app/data/local_database/app_local_db.dart';
import 'package:plain_registry_app/workflow/chat/chat_worflow.dart';
import 'package:plain_registry_app/workflow/home/home_worflow.dart';
import 'package:plain_registry_app/root/app_entry.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Animate.restartOnHotReload = true;

  await Future.wait([
    AppLocalDb.instance.loadDataBase(),
    AppCameras.instance.loadCameras(),
    GeminiApi.instance.loadCredentials(),
  ]);

  HomeWorflow.register();
  ChatWorkflow.register();
  runApp(const AppEntry());
}
