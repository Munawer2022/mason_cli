import 'package:flutter/material.dart';

class AppNavigator {
  void push({required BuildContext context, required Route route}) {
    Navigator.of(context).push(route);
  }

  void pushNamed(
          {required BuildContext context,
          required String routeName,
          Object? arguments}) =>
      Navigator.of(context).pushNamed(routeName, arguments: arguments);

  void pushReplacement({required BuildContext context, required Route route}) {
    Navigator.of(context).pushReplacement(route);
  }

  void pushReplacementNamed(
          {required BuildContext context,
          required String routeName,
          Object? arguments}) =>
      Navigator.of(context)
          .pushReplacementNamed(routeName, arguments: arguments);

  void pushAndRemoveUntil(
      {required BuildContext context,
      required Route route,
      required RoutePredicate predicate}) {
    Navigator.of(context).pushAndRemoveUntil(route, predicate);
  }

  void pushNamedAndRemoveUntil(
          {required BuildContext context,
          required String routeName,
          required RoutePredicate predicate,
          Object? arguments}) =>
      Navigator.of(context)
          .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);

  void pop(BuildContext context, [Object? result]) =>
      Navigator.of(context).pop(result);

  void canPop(BuildContext context) => Navigator.of(context).canPop();

  void popUntil(
          {required BuildContext context, required RoutePredicate predicate}) =>
      Navigator.of(context).popUntil(predicate);
}
