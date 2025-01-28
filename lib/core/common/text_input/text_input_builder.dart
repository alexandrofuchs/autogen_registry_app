import 'package:flutter/material.dart';
import 'package:plain_registry_app/core/common/text_input/text_input_validator.dart';
import 'package:plain_registry_app/core/theme/app_colors.dart';
import 'package:plain_registry_app/core/theme/app_text_styles.dart';

class TextInputBuilder extends StatelessWidget {
  final String label;
  final TextInputValidator inputValidator;
  final int? maxLength;
  final int? maxLines;
  final bool hasError = false;
  final String errorText;

  const TextInputBuilder(
      {super.key,
      required this.label,
      required this.inputValidator,
      this.maxLength,
      this.maxLines,
      required this.errorText});

  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(
            color: AppColors.primaryColorDark,
            boxShadow: [
              BoxShadow(
                color: AppColors.secundaryColor,
                spreadRadius: 1,
                blurRadius: 1,
              )
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45),
                topRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(45))),
        margin: const EdgeInsets.all(15),
        child: TextField(
          controller: inputValidator.controller,
          style: AppTextStyles.labelStyleSmall,
          maxLength: maxLength,
          maxLines: maxLines,
          onChanged: (value) {
            inputValidator.hasError = value.isEmpty;
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: AppTextStyles.labelStyleSmall,
              alignLabelWithHint: true,
              error: ValueListenableBuilder(
                  valueListenable: inputValidator,
                  builder: (context, hasError, child) => hasError
                      ? Row(
                          children: [
                            const Icon(
                              Icons.warning_outlined,
                              size: 14,
                              color: AppColors.orangeDark,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              errorText,
                              style: AppTextStyles.bodyStyleSmall.copyWith(
                                  color: AppColors.orangeDark,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        )
                      : const SizedBox()),
              hintText: label,
              counterStyle: const TextStyle(
                  color: AppColors.secundaryColor, fontWeight: FontWeight.w700),
              contentPadding:
                  const EdgeInsets.only(left: 30, right: 30, top: 15)),
        ),
      );
}
