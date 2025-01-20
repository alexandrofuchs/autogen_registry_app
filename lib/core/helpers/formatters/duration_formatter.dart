import 'package:flutter/material.dart';

extension DurationFormatter on Duration {
  String formatTime({bool showSeconds = true}) {
    try {
      final seconds = inSeconds;

      if (seconds >= 3600) {
        final hour = (seconds ~/ 3600);
        final restMin = seconds % 3600;
        num min = (restMin ~/ 60);
        num sec = (restMin % 60);
        return "${hour > 9 ? hour : '0$hour'}:${min > 9 ? min : '0$min'}${showSeconds ? ':${sec > 9 ? sec : '0$sec'}' : ''}";
      }

      if (seconds >= 60) {
        final min = seconds ~/ 60;
        final sec = seconds % 60;
        return "00:${min > 9 ? min : '0$min'}${showSeconds ? ':${sec > 9 ? sec : '0$sec'}' : ''}";
      }

      return "00:00:${seconds > 9 ? seconds : "0$seconds"}";
    } catch (e) {
      debugPrint(e.toString());
      return '';
    }
  }
}
