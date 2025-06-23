import 'package:flutter/material.dart';

class AppNavigator {
  push({required BuildContext context, required Route route}) =>
      Navigator.of(context).push(route);

  pushNamed(
          {required BuildContext context,
          required String routeName,
          Object? arguments}) =>
      Navigator.of(context).pushNamed(routeName, arguments: arguments);

  pushReplacement({required BuildContext context, required Route route}) =>
      Navigator.of(context).pushReplacement(route);

  pushReplacementNamed(
          {required BuildContext context,
          required String routeName,
          Object? arguments}) =>
      Navigator.of(context)
          .pushReplacementNamed(routeName, arguments: arguments);

  pushAndRemoveUntil(
          {required BuildContext context,
          required Route route,
          required RoutePredicate predicate}) =>
      Navigator.of(context).pushAndRemoveUntil(route, predicate);

  pushNamedAndRemoveUntil(
          {required BuildContext context,
          required String routeName,
          required RoutePredicate predicate,
          Object? arguments}) =>
      Navigator.of(context)
          .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);

  pop(BuildContext context, [Object? result]) =>
      Navigator.of(context).pop(result);

  canPop(BuildContext context) => Navigator.of(context).canPop();

  popUntil(
          {required BuildContext context, required RoutePredicate predicate}) =>
      Navigator.of(context).popUntil(predicate);
}
