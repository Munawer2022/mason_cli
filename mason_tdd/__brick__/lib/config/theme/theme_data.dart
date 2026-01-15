import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

// Theme
ThemeData get lightTheme => ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: AppColors.lightColorScheme,
  textTheme: AppTextStyles.textTheme,
  primaryTextTheme: AppTextStyles.textTheme,

  // App Bar Theme
  appBarTheme: const AppBarTheme(elevation: 0, centerTitle: true),

  // Elevated Button Theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      // foregroundColor: Colors.white,
      elevation: 0,
      minimumSize: Size(double.infinity.w, 48.h),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      //   textStyle: AppTextStyles.textTheme.titleMedium?.copyWith(
      //   fontWeight: FontWeight.w600,
      // ),
    ),
  ),

  // Outlined Button Theme
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      // foregroundColor: Colors.white,
      minimumSize: Size(double.infinity.w, 48.h),
      // side: const BorderSide(color: Colors.grey),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      // textStyle: AppTextStyles.textTheme.titleMedium?.copyWith(
      //   fontWeight: FontWeight.w600,
      // ),
    ),
  ),

  // Text Button Theme
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      // foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 8.h),
    ),
  ),

  // Input Decoration Theme
  inputDecorationTheme: InputDecorationTheme(
    // filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(color: Colors.grey.shade400),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(color: Colors.grey.shade400),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(width: 2.w),
    ),
    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
    contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
  ),

  // Bottom Navigation Bar Theme
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 8,
  ),

  // Divider Theme
  dividerTheme: const DividerThemeData(thickness: 1, space: 1),
);

ThemeData get darkTheme => ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: AppColors.darkColorScheme,
  textTheme: AppTextStyles.textTheme,
  primaryTextTheme: AppTextStyles.textTheme,
);
