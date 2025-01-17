import 'package:flutter/material.dart';
import 'package:plain_registry_app/core/theme/app_colors.dart';
import 'package:plain_registry_app/core/theme/app_text_styles.dart';

abstract class AppTheme {
  static ThemeData defaultTheme(BuildContext context) =>
    ThemeData.light().copyWith(
      scaffoldBackgroundColor: AppColors.backgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryColorDark,
        elevation: 1,
        toolbarHeight: 0,
      ),
      inputDecorationTheme:  InputDecorationTheme(
        hintStyle: AppTextStyles.labelStyleMedium,
      ),
      bottomAppBarTheme: BottomAppBarTheme(
        color: AppColors.secundaryColor,
      ),
      textTheme: TextTheme(
        titleLarge: AppTextStyles.titleStyleLarge,
        titleMedium: AppTextStyles.titleStyleMedium,
        titleSmall: AppTextStyles.titleStyleSmall,
        bodyLarge: AppTextStyles.bodyStyleLarge,
        bodyMedium: AppTextStyles.bodyStyleMedium,
        bodySmall: AppTextStyles.bodyStyleSmall,
        labelLarge: AppTextStyles.labelStyleLarge,
        labelMedium: AppTextStyles.labelStyleMedium,
        labelSmall: AppTextStyles.labelStyleSmall,
      ),
      iconTheme: IconThemeData(
        size: 32,
        color: AppColors.primaryColorDark,
      ),
      dividerColor: AppColors.primaryColorDark,
      dividerTheme: DividerThemeData(
        thickness: 2,
        color: AppColors.primaryColorDark,
      )
    );
}
