import 'package:flutter/material.dart';
import 'package:plain_registry_app/core/theme/app_colors.dart';
import 'package:plain_registry_app/core/widgets/searchbar/searchbar_widget.dart';

mixin AppbarWidgets on SearchbarWidget {
  Widget _backgroundWidget() => Column(
        children: [
          Container(
            decoration:
                BoxDecoration(gradient: AppGradients.primaryColors, boxShadow: [
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
          ),
          Container(
            height: 50,
            color: AppColors.backgroundColor,
          )
        ],
      );

  PreferredSize searchAppBarBottom() => PreferredSize(
      preferredSize: const Size.fromHeight(150),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          _backgroundWidget(),
          Container(
            decoration: BoxDecoration(
                color: AppColors.secundaryColor,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5),
                    bottomRight: Radius.circular(100)),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.primaryColorDark,
                      offset: const Offset(0, 2),
                      blurRadius: 2,
                      spreadRadius: -2)
                ]),
            margin: const EdgeInsets.only(bottom: 20, left: 25, right: 25),
            child: searchBar(),
          )
        ],
      ));
}
