import 'package:flutter/material.dart';
import 'package:plain_registry_app/core/theme/app_colors.dart';
import 'package:plain_registry_app/core/theme/app_text_styles.dart';

mixin SearchbarWidget {
  Widget searchBar(Function(String value) onTextChange) => Container(
        height: 50,
        decoration: const BoxDecoration(
            color: AppColors.secundaryColor,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(100),
                bottomLeft: Radius.circular(50),
                topLeft: Radius.circular(100),
                topRight: Radius.circular(50))),
        margin: const EdgeInsets.only(left: 15, right: 15),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Icon(
                Icons.search,
                color: AppColors.primaryColorDark,
              ),
            ),
            Expanded(
              child: TextField(
                cursorColor: AppColors.primaryColorDark,
                onChanged: onTextChange,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'pesquisar',
                    hintStyle: AppTextStyles.titleStyleMedium,
                    labelStyle: AppTextStyles.titleStyleMedium),
              ),
            ),
          ],
        ),
      );
}
