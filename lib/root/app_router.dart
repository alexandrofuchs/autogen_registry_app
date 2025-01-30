import 'package:flutter/material.dart';

enum RouteTransition{
  leftToRight(Offset(-1.0, 0.0)),
  rightToLeft(Offset(1.0, 0.0)),
  downToUp(Offset(0.0, 1.0)),
  upToDown((Offset(0.0, -1.0)));

  const RouteTransition(this.offset);

  final Offset offset;
}

abstract class AppRouter {
  static Route<T> route<T>(Widget page, {RouteTransition transition = RouteTransition.rightToLeft} ) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin = transition.offset;
        const end = Offset.zero;
        const curve = Curves.decelerate;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}