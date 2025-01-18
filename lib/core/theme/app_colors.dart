import 'package:flutter/material.dart';

abstract class AppColors {
  static Color primaryColorDark = const Color(0xff0A434E);
  static Color primaryColor = const Color(0xff05445E);
  static Color primaryColorLight = const Color(0xff189AB4);
  static Color backgroundColor = const Color(0xffd4f1f4);
  static Color secundaryColor = const Color(0xffffffff);

  static Color greenDark = const Color(0xff009343);
  static Color greenLight = const Color(0xff70FFB2);

  static Color orangeDark = const Color(0xffFF3A3A);
  static Color orangeLight = const Color(0xffFF7474);
  
}

abstract class AppGradients {
  static LinearGradient primaryColors = const LinearGradient(
    colors: [
      Color(0xff05445E),
      Color(0xff189AB4),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static LinearGradient actionColors = const LinearGradient(
    colors: [
      Color(0xff70FFB2),
      Color(0xff009343),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
