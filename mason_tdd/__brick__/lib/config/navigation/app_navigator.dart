import 'package:flutter/material.dart';

import 'transition_type.dart';
import 'transition_type_checker.dart';

class AppNavigator with TransitionTypeChecker {
  push(
          {required BuildContext context,
          required Widget routeName,
          TransitionType transitionType = TransitionType.slideFromRight}) =>
      Navigator.of(context)
          .push(transitionTypeChecker(routeName, transitionType));

  pushNamed(
          {required BuildContext context,
          required String routeName,
          Object? arguments}) =>
      Navigator.of(context).pushNamed(routeName, arguments: arguments);

  pushReplacement(
          {required BuildContext context,
          required Widget routeName,
          TransitionType transitionType = TransitionType.slideFromRight}) =>
      Navigator.of(context)
          .pushReplacement(transitionTypeChecker(routeName, transitionType));

  pushReplacementNamed(
          {required BuildContext context,
          required String routeName,
          Object? arguments}) =>
      Navigator.of(context)
          .pushReplacementNamed(routeName, arguments: arguments);

  pushAndRemoveUntil(
          {required BuildContext context,
          required Widget routeName,
          required RoutePredicate predicate,
          TransitionType transitionType = TransitionType.slideFromRight}) =>
      Navigator.of(context).pushAndRemoveUntil(
          transitionTypeChecker(routeName, transitionType), predicate);

  pushNamedAndRemoveUntil(
          {required BuildContext context,
          required String routeName,
          required RoutePredicate predicate,
          Object? arguments}) =>
      Navigator.of(context)
          .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);

  pop(BuildContext context, [Object? result]) =>
      Navigator.of(context).pop(result);

  bool canPop(BuildContext context) => Navigator.of(context).canPop();

  popUntil(
          {required BuildContext context, required RoutePredicate predicate}) =>
      Navigator.of(context).popUntil(predicate);
}
