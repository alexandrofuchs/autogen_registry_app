import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData defaultTheme(BuildContext context) =>
    ThemeData.light().copyWith();
}
