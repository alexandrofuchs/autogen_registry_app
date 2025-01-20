import 'package:flutter/material.dart';
import 'package:plain_registry_app/core/theme/app_colors.dart';
import 'package:plain_registry_app/core/theme/app_text_styles.dart';

mixin AppbarWidgets {
  Widget _backgroundWidget(String label) => Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: 15),
            decoration:
                BoxDecoration(
                  gradient: AppGradients.primaryColors, boxShadow: [
              BoxShadow(
                offset: const Offset(0, 0),
                spreadRadius: 0,
                blurRadius: 1,
                color: Colors.black.withAlpha(200),
              ),
              BoxShadow(
                color: AppColors.secundaryColor,
              )
            ]),
            height: 100,
            child: Text(label, style: AppTextStyles.labelStyleLarge,),
          ),
          Container(
            height: 50,
            color: AppColors.backgroundColor,
            
          )
        ],
      );

  PreferredSize appBarBottom({Widget? child, String? label}) => PreferredSize(
      preferredSize: const Size.fromHeight(150),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          _backgroundWidget(label ?? ''),
          Container(
            decoration: BoxDecoration(
                color: AppColors.secundaryColor,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5),
                    bottomRight: Radius.circular(100)),
                boxShadow: const []),
            margin: const EdgeInsets.only(bottom: 20, left: 25, right: 25),
            child: child,
          )
        ],
      ));
}
