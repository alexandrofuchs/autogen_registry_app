import 'package:flutter/material.dart';
import 'package:plain_registry_app/core/theme/app_colors.dart';
import 'package:plain_registry_app/core/theme/app_text_styles.dart';

mixin CommonWidgets {
  Widget headerContainer(String text) => Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.primaryColors,
          borderRadius: BorderRadius.only(
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
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: AppColors.secundaryColor,
            border: Border.all(width: 0.5, color: AppColors.primaryColorDark),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
            boxShadow: [
              BoxShadow(
                  blurRadius: 1,
                  spreadRadius: 0,
                  color: Colors.black.withAlpha(100),
                  offset: const Offset(1, 1))
            ]),
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
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25)),
                        gradient: AppGradients.primaryColors),
                    height: 45,
                    width: 100,
                    child: const Text(
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

  Widget filterBar() => Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 10),
            _filterItem('filtrar tipo arquivo'),
          ],
        ),
      );

  Widget fieldContainer({Widget? child}) => Container(
        decoration: const BoxDecoration(
            color: AppColors.secundaryColor,
            borderRadius: BorderRadius.only(
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
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.greenLight,
                  offset: Offset(0, 2),
                  spreadRadius: 0,
                  blurRadius: 2,
                )
              ],
              gradient: AppGradients.actionColors,
              borderRadius: BorderRadius.only(
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

  Widget titleDot(String text) => SizedBox(
        height: 50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 5),
              decoration: BoxDecoration(
                color: AppColors.primaryColorDark,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            Flexible(
                child: Text(
              text,
              style: AppTextStyles.bodyStyleLarge
                  .copyWith(fontWeight: FontWeight.w300),
              softWrap: true,
            )),
          ],
        ),
      );

  Widget itemDot(String text) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColorDark,
              borderRadius: BorderRadius.circular(10),
            ),
            width: 10,
            height: 10,
          ),
          const SizedBox(width: 15),
          Flexible(
              child: Text(
            text,
            style: AppTextStyles.titleStyleLarge,
            softWrap: true,
          )),
        ],
      );
}
