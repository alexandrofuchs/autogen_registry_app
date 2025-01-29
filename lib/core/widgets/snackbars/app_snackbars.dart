import 'package:flutter/material.dart';
import 'package:autogen_registry_app/core/theme/app_colors.dart';

abstract class AppSnackbars {
  static SnackBar _snackBar(BuildContext context, Duration duration,
          String message, Color color) =>
      SnackBar(
        margin: const EdgeInsets.only(left: 8, right: 8, bottom: 30),
        backgroundColor: color,
        duration: duration,
        shape: const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
        behavior: SnackBarBehavior.floating,
        content: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
          child: Row(
            children: [
              const Icon(
                Icons.cancel_rounded,
                color: AppColors.secundaryColor,
                size: 24,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    message,
                    softWrap: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      showErrorSnackbar(BuildContext context, String message,
              {Duration duration = const Duration(seconds: 2)}) =>
          ScaffoldMessenger.of(context).showSnackBar(
              _snackBar(context, duration, message, AppColors.orangeDark));

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      showSuccessSnackbar(BuildContext context, String message,
              {Duration duration = const Duration(seconds: 2)}) =>
          ScaffoldMessenger.of(context).showSnackBar(
              _snackBar(context, duration, message, AppColors.greenDark));
}
