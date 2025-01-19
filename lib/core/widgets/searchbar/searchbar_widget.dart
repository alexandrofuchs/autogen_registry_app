import 'package:flutter/material.dart';
import 'package:plain_registry_app/core/theme/app_colors.dart';
import 'package:plain_registry_app/core/theme/app_text_styles.dart';

mixin SearchbarWidget {
  Widget searchBar(Function(String value) onTextChange) => Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Icon(Icons.search),
            ),
            Expanded(
              child: TextField(
                cursorColor: AppColors.primaryColorDark,
                onChanged: onTextChange,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'search',
                    hintStyle: AppTextStyles.bodyStyleMedium,
                    labelStyle: AppTextStyles.bodyStyleMedium),
              ),
            ),
          ],
        ),
      );
}
