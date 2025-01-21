import 'package:flutter/material.dart';
import 'package:plain_registry_app/core/theme/app_colors.dart';

abstract class AppGradients {
  static const LinearGradient primaryColors = LinearGradient(
    colors: [
      AppColors.primaryColor,
      AppColors.primaryColorLight
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient positiveActionColors = LinearGradient(
    colors: [
      AppColors.greenLight,
      AppColors.greenDark,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient negativeActionColors = LinearGradient(
    colors: [
      AppColors.orangeLight,
      AppColors.orangeDark,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
