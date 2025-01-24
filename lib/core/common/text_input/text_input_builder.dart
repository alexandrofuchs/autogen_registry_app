import 'package:flutter/material.dart';
import 'package:plain_registry_app/core/common/text_input/text_input_validator.dart';
import 'package:plain_registry_app/core/theme/app_colors.dart';
import 'package:plain_registry_app/core/theme/app_text_styles.dart';

class TextInputBuilder extends StatefulWidget {
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
  State<StatefulWidget> createState() => _TextInputBuilderState();
}

class _TextInputBuilderState extends State<TextInputBuilder> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.inputValidator.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(
            color: AppColors.secundaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45),
                topRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(45))),
        margin: const EdgeInsets.all(15),
        child: TextField(
          controller: widget.inputValidator.controller,
          style: AppTextStyles.bodyStyleMedium,
          maxLength: widget.maxLength,
          maxLines: widget.maxLines,
          onChanged: (value) {
            widget.inputValidator.hasError = value.isEmpty;
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: AppTextStyles.bodyStyleMedium,
              alignLabelWithHint: true,
              error: ValueListenableBuilder(
                  valueListenable: widget.inputValidator,
                  builder: (context, hasError, child) =>
                      hasError ? 
                      Row(
                        children: [
                          const Icon(Icons.warning_outlined, size: 14, color: AppColors.orangeDark,),
                          const SizedBox(width: 10,),
                          Text(widget.errorText, style: AppTextStyles.bodyStyleSmall.copyWith(color: AppColors.orangeDark, fontWeight: FontWeight.w600),),
                        ],
                      ) : const SizedBox()),
              hintText: widget.label,
              counterStyle: const TextStyle(
                  color: AppColors.primaryColor, fontWeight: FontWeight.w700),
              contentPadding:
                  const EdgeInsets.only(left: 30, right: 30, top: 15)),
        ),
      );
}
