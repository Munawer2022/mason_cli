import 'package:flutter/material.dart';

abstract class GlobalConstants {
  static const String themeKey = "IS_DARK_THEME";
}

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
