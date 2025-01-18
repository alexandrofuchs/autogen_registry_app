import 'package:flutter/material.dart';
import 'package:plain_registry_app/core/theme/app_colors.dart';
import 'package:plain_registry_app/core/theme/app_text_styles.dart';

mixin CommonWidgets {
  Widget divider() => const Padding(
        padding: EdgeInsets.only(left: 25, right: 25),
        child: Divider(),
      );

  Widget item(IconData icon, String title) => Container(
        margin: const EdgeInsets.only(left: 25, right: 25, bottom: 15),
        decoration: BoxDecoration(
          color: AppColors.secundaryColor,
          border: Border.all(color: AppColors.primaryColorDark, width: 0.5),
        ),
        padding: const EdgeInsets.all(25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon),
            const SizedBox(width: 15),
            Text(
              title,
              style: AppTextStyles.bodyStyleSmall,
            ),
          ],
        ),
      );

  Widget filterBar() => Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.topLeft,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primaryColorDark,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1.5, color: AppColors.primaryColorDark),
          ),
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
          child: Text('docs', style: AppTextStyles.labelStyleSmall),
        ),
      );

  Widget fieldContainer({Widget? child}) => Container(
        decoration: BoxDecoration(
            color: AppColors.secundaryColor,
            borderRadius: const BorderRadius.only(

                topLeft: Radius.circular(45),
                topRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(45))),
        margin: const EdgeInsets.all(15),
        child: child,
      );

  Widget textField(String label, TextEditingController controller) =>
      fieldContainer(
        child: TextField(
          controller: controller,
          style: AppTextStyles.bodyStyleMedium,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: AppTextStyles.bodyStyleSmall,
              hintText: label,
              contentPadding: const EdgeInsets.all(15)),
        ),
      );

  Widget actionButton(String label, Function() action, bool enable) => Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: enable ? action : null,
          child: Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.greenLight,
                  offset: const Offset(0, 2),
                  spreadRadius: 0,
                  blurRadius: 2,
                )
              ],
              gradient: AppGradients.actionColors,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
            ),
            padding: const EdgeInsets.only(left: 15),
            width: 150,
            height: 50,
            child: Text(
              label,
              style: AppTextStyles.labelStyleLarge.copyWith(
                  color: enable
                      ? AppColors.secundaryColor
                      : AppColors.primaryColorDark),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
}
