import 'package:flutter/material.dart';

extension TextThemeExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension BuildContextExtension on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
  Color get adaptiveColor =>
      isDarkMode ? Theme.of(this).colorScheme.secondary : Colors.black;
}

extension ColorExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
}
