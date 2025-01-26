import 'package:flutter/material.dart';
import 'package:plain_registry_app/core/theme/app_colors.dart';
import 'package:plain_registry_app/core/theme/app_gradients.dart';
import 'package:plain_registry_app/core/theme/app_text_styles.dart';

mixin CommonWidgets {

   Widget titleContainer(String text, {Function()? backAction}) => Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.primaryColors,
          border: Border(top: BorderSide(color: AppColors.primaryColorLight, width: 1)),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          color: AppColors.primaryColor,
        ),
        height: 50,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             backAction != null?
             BackButton(color: AppColors.secundaryColor,
            onPressed: () {
              backAction();
            },
            ): const SizedBox(),
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: AppTextStyles.labelStyleLarge,
              ),
            ),
            const SizedBox(width: 24, height: 24,),
          ],
        ),
      );

  Widget pageHeader(String label) =>
  Container(
              alignment: Alignment.bottomCenter,
              height: 50,
              child: Text(
                label,
                style: AppTextStyles.labelStyleLarge,
              ));

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


   Widget actionButton(IconData icon, String label, Function() action, {bool enable = true}) => 
    Align(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: enable ? action : null,
          child: Container(
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColorDark,
                  offset: Offset(0, 2),
                  spreadRadius: 0,
                  blurRadius: 2,
                )
              ],
              gradient: AppGradients.actionColors,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
            ),
            padding: const EdgeInsets.only(left: 8),
            width: 150,
            height: 50,
            child: Row(
              children: [
                Icon(icon, color: AppColors.secundaryColor,),
                Expanded(
                  child: Text(
                    label,
                    style: AppTextStyles.labelStyleLarge.copyWith(
                        color: enable
                            ? AppColors.secundaryColor
                            : AppColors.primaryColorDark),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget positiveActionButton(String label, Function() action, {bool enable = true}) => Align(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: enable ? action : null,
          child: Container(
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColorDark,
                  offset: Offset(0, 2),
                  spreadRadius: 0,
                  blurRadius: 2,
                )
              ],
              gradient: AppGradients.positiveActionColors,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(0),
                bottomRight: Radius.circular(0),
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

   Widget negativeActionButton(String label, Function() action, {bool enable = true}) => Align(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: enable ? action : null,
          child: Container(
            alignment: Alignment.centerRight,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColorDark,
                  offset: Offset(0, 2),
                  spreadRadius: 0,
                  blurRadius: 2,
                )
              ],
              gradient: AppGradients.negativeActionColors,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
                  topLeft: Radius.circular(0),
                  bottomLeft: Radius.circular(0)),
            ),
            padding: const EdgeInsets.only(right: 15),
            width: 150,
            height: 50,
            child: Text(
              label,
              style: AppTextStyles.labelStyleLarge.copyWith(
                  color: Colors.white),
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
                color: AppColors.secundaryColor,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            Flexible(
                child: Text(
              text,
              style: AppTextStyles.labelStyleMedium,
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
