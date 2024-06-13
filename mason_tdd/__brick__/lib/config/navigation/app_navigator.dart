import 'package:flutter/material.dart';

import 'transition_type.dart';
import 'transition_type_checker.dart';

class AppNavigator with TransitionTypeChecker {
  void push({
    required BuildContext context,
    required Widget routeName,
    TransitionType transitionType = TransitionType.slideFromRight,
  }) {
    Navigator.of(context).push(
      transitionTypeChecker(routeName, transitionType),
    );
  }

  void pushNamed({
    required BuildContext context,
    required String routeName,
    Object? arguments,
  }) =>
      Navigator.of(context).pushNamed(routeName, arguments: arguments);

  void pushReplacement({
    required BuildContext context,
    required Widget routeName,
    TransitionType transitionType = TransitionType.slideFromRight,
  }) {
    Navigator.of(context).pushReplacement(
      transitionTypeChecker(routeName, transitionType),
    );
  }

  void pushReplacementNamed({
    required BuildContext context,
    required String routeName,
    Object? arguments,
  }) =>
      Navigator.of(context)
          .pushReplacementNamed(routeName, arguments: arguments);

  void pushAndRemoveUntil({
    required BuildContext context,
    required Widget routeName,
    required RoutePredicate predicate,
    TransitionType transitionType = TransitionType.slideFromRight,
  }) {
    Navigator.of(context).pushAndRemoveUntil(
      transitionTypeChecker(routeName, transitionType),
      predicate,
    );
  }

  void pushNamedAndRemoveUntil({
    required BuildContext context,
    required String routeName,
    required RoutePredicate predicate,
    Object? arguments,
  }) =>
      Navigator.of(context)
          .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);

  void pop(BuildContext context, [Object? result]) =>
      Navigator.of(context).pop(result);

  bool canPop(BuildContext context) => Navigator.of(context).canPop();

  void popUntil(
          {required BuildContext context, required RoutePredicate predicate}) =>
      Navigator.of(context).popUntil(predicate);
}
