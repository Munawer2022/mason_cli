import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class Themes {
  static ThemeData get light => ThemeData().copyWith(
      brightness: Brightness.light,
      // fontFamily: 'Poppins',
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
      ),
      textTheme: const TextTheme());

  static ThemeData get dark => ThemeData.dark().copyWith();
}
