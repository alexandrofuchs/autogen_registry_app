import 'package:flutter/material.dart';
import 'package:plain_registry_app/workflow/home/home_worflow.dart';
import 'package:plain_registry_app/workflow/root/app_entry.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  HomeWorflow.register();
  runApp(const AppEntry());
}
