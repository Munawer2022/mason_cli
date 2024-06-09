import 'package:flutter/material.dart';
import 'transitions.dart';
import 'transitions_checker.dart';

class AppNavigator {
  void push(
    BuildContext context,
    Widget routeName, {
    Object? arguments,
    TransitionType transitionType = TransitionType.slideFromRight,
  }) {
    final route = _getPageRoute(routeName, transitionType);
    Navigator.of(context).push(route);
  }

  void pushNamed(BuildContext context, String routeName, {Object? arguments}) =>
      Navigator.of(context).pushNamed(routeName, arguments: arguments);

  static void pop(BuildContext context) => Navigator.of(context).pop();

  PageRouteBuilder<T> _getPageRoute<T>(
      Widget routeName, TransitionType transitionType) {
    switch (transitionType) {
      case TransitionType.slideFromLeft:
        return SlideFromLeftPageRoute(widget: routeName);
      case TransitionType.slideFromTop:
        return SlideFromTopPageRoute(widget: routeName);
      case TransitionType.slideFromBottom:
        return SlideFromBottomPageRoute(widget: routeName);
      case TransitionType.slideFromRight:
      default:
        return SlideFromRightPageRoute(widget: routeName);
    }
  }
}
