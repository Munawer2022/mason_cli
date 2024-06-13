import 'package:flutter/material.dart';

import 'transition_type.dart';
import 'transitions.dart';

mixin TransitionTypeChecker {
  PageRouteBuilder<T> transitionTypeChecker<T>(
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
