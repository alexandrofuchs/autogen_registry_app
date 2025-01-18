import 'package:flutter/material.dart';
import 'package:plain_registry_app/core/theme/app_colors.dart';

mixin SearchbarWidget {
  Widget searchBar() => Padding(

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
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'search',
                    labelStyle: TextStyle(
                      backgroundColor: AppColors.primaryColorDark,
                    )),
                style: TextStyle(
                    decorationColor: AppColors.primaryColorDark,
                    color: AppColors.primaryColorDark),
              ),
            ),
          ],
        ),
      );
}