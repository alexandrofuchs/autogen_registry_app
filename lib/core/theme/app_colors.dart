import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primaryColorDark = Color(0xff0A434E);
  static const Color primaryColor = Color(0xff05445E);
  static const Color primaryColorLight = Color(0xff189AB4);
  static const Color backgroundColor = Color(0xffd4f1f4);
  static const Color secundaryColor = Color(0xffffffff);

  static const Color greenDark = Color(0xff009343);
  static const Color greenLight = Color(0xff70FFB2);

  static const Color orangeDark = Color(0xffFF3A3A);
  static const Color orangeLight = Color(0xffFF7474);
}

abstract class AppGradients {
  static const LinearGradient primaryColors = LinearGradient(
    colors: [
      Color(0xff05445E),
      Color(0xff189AB4),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient actionColors = LinearGradient(
    colors: [
      Color(0xff70FFB2),
      Color(0xff009343),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
