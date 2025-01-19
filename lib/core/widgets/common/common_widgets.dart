import 'package:flutter/material.dart';
import 'package:plain_registry_app/core/theme/app_colors.dart';
import 'package:plain_registry_app/core/theme/app_text_styles.dart';

mixin CommonWidgets {
  Widget headerContainer(String text) => Container(
        decoration: BoxDecoration(
          gradient: AppGradients.primaryColors,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          color: AppColors.primaryColor,
        ),
        height: 35,
        alignment: Alignment.center,
        child: Text(
          text,
          style: AppTextStyles.labelStyleLarge,
        ),
      );

  Widget divider() => const Padding(
        padding: EdgeInsets.only(left: 25, right: 25),
        child: Divider(),
      );

  Widget item(IconData icon, String title, String furtherInfo) => Container(
        margin: const EdgeInsets.only(left: 25, right: 25, bottom: 15),
        decoration: BoxDecoration(
          color: AppColors.secundaryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(0),
          ),
          border: Border.all(color: AppColors.primaryColorDark, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(icon),
                  const SizedBox(width: 15),
                  Text(
                    title,
                    softWrap: true,
                    style: AppTextStyles.bodyStyleMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 15),
                  child: Text(
                    furtherInfo,
                    style: AppTextStyles.bodyStyleSmall,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25)),
                        gradient: AppGradients.primaryColors),
                    height: 45,
                    width: 100,
                    child: Text(
                      'excluir',
                      style: AppTextStyles.labelStyleSmall,
                      softWrap: true,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      );

  Widget filterBar() => Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.topLeft,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primaryColorDark,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(50),
            ),
            border: Border.all(width: 1.5, color: AppColors.primaryColorDark),
          ),
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
          child: Text('docs', style: AppTextStyles.labelStyleSmall),
        ),
      );

  Widget _filterItem(String label) => Container(
        decoration: BoxDecoration(
          color: AppColors.secundaryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(50),
          ),
          border: Border.all(width: 1.5, color: AppColors.primaryColorDark),
        ),
        padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
        child: Text(
          label,
          style: AppTextStyles.bodyStyleMedium
              .copyWith(fontStyle: FontStyle.italic),
        ),
      );

  Widget unselectedFilterBar() => Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.topLeft,
        child: Row(
          children: [
            _filterItem('filtrar categoria'),
            const SizedBox(width: 10),
            _filterItem('filtrar tipo arquivo'),
          ],
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
