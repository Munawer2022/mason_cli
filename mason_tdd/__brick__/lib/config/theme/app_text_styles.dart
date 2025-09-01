import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// App Text Styles - Centralized typography definitions
class AppTextStyles {
  // Private constructor to prevent instantiation
  AppTextStyles._();

  // Display Styles
  static TextStyle get displayLarge =>
      TextStyle(fontSize: 57.sp, fontWeight: FontWeight.w400);

  static TextStyle get displayMedium =>
      TextStyle(fontSize: 45.sp, fontWeight: FontWeight.w400);

  static TextStyle get displaySmall =>
      TextStyle(fontSize: 36.sp, fontWeight: FontWeight.w400);

  // Headline Styles
  static TextStyle get headlineLarge =>
      TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w400);

  static TextStyle get headlineMedium =>
      TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w400);

  static TextStyle get headlineSmall =>
      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w400);

  // Title Styles
  static TextStyle get titleLarge =>
      TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w400);

  static TextStyle get titleMedium =>
      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500);

  static TextStyle get titleSmall =>
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500);

  // Body Styles
  static TextStyle get bodyLarge =>
      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400);

  static TextStyle get bodyMedium =>
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400);

  static TextStyle get bodySmall =>
      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400);

  // Label Styles
  static TextStyle get labelLarge =>
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500);

  static TextStyle get labelMedium =>
      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500);

  static TextStyle get labelSmall =>
      TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500);

  /// Get the complete TextTheme
  static TextTheme get textTheme => TextTheme(
    displayLarge: displayLarge,
    displayMedium: displayMedium,
    displaySmall: displaySmall,
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    labelSmall: labelSmall,
  );
}
