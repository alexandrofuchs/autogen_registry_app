import 'package:flutter/material.dart';
import 'package:plain_registry_app/core/theme/app_colors.dart';

abstract class AppTextStyles {
  static TextStyle titleStyleLarge = TextStyle(color: AppColors.primaryColorDark, fontSize: 18, fontWeight: FontWeight.w500);
  static TextStyle titleStyleMedium = TextStyle(color: AppColors.primaryColorDark, fontSize: 16, fontWeight: FontWeight.w400);
  static TextStyle titleStyleSmall = TextStyle(color: AppColors.primaryColorDark, fontSize: 14, fontWeight: FontWeight.w300);

  static TextStyle labelStyleLarge = TextStyle(color: AppColors.secundaryColor, fontSize: 16, fontWeight: FontWeight.w500);
  static TextStyle labelStyleMedium = TextStyle(color: AppColors.secundaryColor, fontSize: 14, fontWeight: FontWeight.w400);
  static TextStyle labelStyleSmall = TextStyle(color: AppColors.secundaryColor, fontSize: 12, fontWeight: FontWeight.w300);

  static TextStyle bodyStyleLarge = TextStyle(color: AppColors.primaryColorDark, fontSize: 16, fontWeight: FontWeight.w500);
  static TextStyle bodyStyleMedium = TextStyle(color: AppColors.primaryColorDark, fontSize: 14, fontWeight: FontWeight.w400);
  static TextStyle bodyStyleSmall = TextStyle(color: AppColors.primaryColorDark, fontSize: 12, fontWeight: FontWeight.w300);
}
