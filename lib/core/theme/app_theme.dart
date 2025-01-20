import 'package:flutter/material.dart';
import 'package:plain_registry_app/core/theme/app_colors.dart';
import 'package:plain_registry_app/core/theme/app_text_styles.dart';

abstract class AppTheme {
  static ThemeData defaultTheme(BuildContext context) =>
      ThemeData.light().copyWith(
        scaffoldBackgroundColor: AppColors.backgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryColor,
          elevation: 1,
          toolbarHeight: 50,
          titleTextStyle: AppTextStyles.labelStyleLarge,
          iconTheme: IconThemeData(color: AppColors.secundaryColor, size: 24)
        ),
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: AppTextStyles.labelStyleMedium,
        ),
        bottomAppBarTheme: const BottomAppBarTheme(
          color: AppColors.secundaryColor,
        ),
        textTheme: const TextTheme(
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
        iconTheme: const IconThemeData(
          size: 32,
          color: AppColors.primaryColorDark,
        ),
        dividerColor: AppColors.primaryColorDark,
        dividerTheme: const DividerThemeData(
          thickness: 2,
          color: AppColors.primaryColorDark,
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: AppColors.primaryColorDark,
        ),
      );
}
