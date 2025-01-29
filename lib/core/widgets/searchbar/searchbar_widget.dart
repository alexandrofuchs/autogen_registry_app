import 'package:flutter/material.dart';
import 'package:autogen_registry_app/core/theme/app_colors.dart';
import 'package:autogen_registry_app/core/theme/app_text_styles.dart';

mixin SearchbarWidget {
  Widget searchBar(Function(String value) onTextChange) => Container(
        height: 60,
        decoration: const BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(100),
                bottomLeft: Radius.circular(50),
                topLeft: Radius.circular(100),
                topRight: Radius.circular(50))),
        margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15,),
              child: Icon(
                Icons.search,
                color: AppColors.secundaryColor,
              ),
            ),
            Expanded(
              child: TextField(
                cursorColor: AppColors.secundaryColor,
                onChanged: onTextChange,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'PESQUISAR...',
                    hintStyle: AppTextStyles.labelStyleMedium,
                    labelStyle: AppTextStyles.labelStyleMedium),
              ),
            ),
          ],
        ),
      );
}
