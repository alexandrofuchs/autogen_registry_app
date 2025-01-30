import 'package:autogen_registry_app/core/widgets/snackbars/app_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:autogen_registry_app/core/theme/app_colors.dart';
import 'package:autogen_registry_app/core/theme/app_gradients.dart';
import 'package:autogen_registry_app/core/theme/app_text_styles.dart';

mixin CommonWidgets {
  Widget titleContainer(String text, {Function()? backAction}) => Container(
                decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          color: AppColors.primaryColorDark,
        ),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            backAction != null
                ? BackButton(
                    color: AppColors.secundaryColor,
                    onPressed: () {
                      backAction();
                    },
                  )
                : const SizedBox(),
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: AppTextStyles.labelStyleLarge,
              ),
            ),
            
          ],
        ),
      );

  Widget toolWidget(BuildContext context, IconData icon, String label, {Function()? action}) =>
    GestureDetector(
      onTap: () {
        if(action == null){
          AppSnackbars.showErrorSnackbar(context, 'ainda não implementado');
          return;  
        }
        action();
      },
      child: Container(decoration: ShapeDecoration(shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            color: AppColors.primaryColor), 
             margin: const EdgeInsets.all(5),
             padding: const EdgeInsets.all(5),
             height: 35, width: 35, child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 Icon(icon, color: AppColors.secundaryColor, size: 24, semanticLabel: label, ),
                 
               ],
             ),
             
             ),
    );

  Widget pageHeader(String label) => Container(
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
        decoration: BoxDecoration(
            color: AppColors.primaryColorDark,
            border: Border.all(color: AppColors.secundaryColor),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(45),
                topRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(45))),
        margin: const EdgeInsets.all(15),
        child: child,
      );

  Widget actionButton(IconData icon, String label, Function() action,
          {bool enable = true}) =>
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
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
            ),
            padding: const EdgeInsets.only(left: 8),
            width: 150,
            height: 45,
            child: Row(
              children: [
                Icon(
                  icon,
                  color: AppColors.secundaryColor,
                ),
                Expanded(
                  child: Text(
                    label,
                    style: AppTextStyles.labelStyleSmall.copyWith(
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

  Widget positiveActionButton(String label, Function() action,
          {bool enable = true}) =>
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

  Widget negativeActionButton(String label, Function() action,
          {bool enable = true}) =>
      Align(
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
              style:
                  AppTextStyles.labelStyleLarge.copyWith(color: Colors.white),
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
              style: AppTextStyles.labelStyleMedium.copyWith(color: AppColors.secundaryColor),
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
