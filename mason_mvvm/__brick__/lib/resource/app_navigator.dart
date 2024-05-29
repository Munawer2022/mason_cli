import 'package:flutter/material.dart';

class AppNavigator {
  void push(BuildContext context, Widget routeName, {Object? arguments}) =>
      Navigator.of(context).push(
          //   MaterialPageRoute(
          //   builder: (context) => routeName,
          // )
          SlideFromRightPageRoute(widget: routeName));

  void pushNamed(BuildContext context, String routeName, {Object? arguments}) =>
      Navigator.of(context).pushNamed(routeName, arguments: arguments);

  static void pop(BuildContext context) => Navigator.of(context).pop();
  //
  // push(BuildContext context, Widget page) {
  // Navigator.of(context).push(
  //           SlideFromRightPageRoute(
  //             widget: page
  //           ),
  //         );
}

class SlideFromRightPageRoute<T> extends PageRouteBuilder<T> {
  final Widget widget;

  SlideFromRightPageRoute({required this.widget})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
}
