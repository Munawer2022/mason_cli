import 'package:flutter/material.dart';

abstract class GlobalConstants {
  static const String themeKey = "IS_DARK_THEME";
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
}
