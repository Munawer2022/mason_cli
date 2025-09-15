import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

// Theme
ThemeData get theme => ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: AppColors.colorScheme,
  textTheme: AppTextStyles.textTheme,
  primaryTextTheme: AppTextStyles.textTheme,

  // App Bar Theme
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.colorScheme.surface,
    foregroundColor: AppColors.colorScheme.onSurface,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: AppTextStyles.titleLarge.copyWith(
      color: AppColors.colorScheme.onSurface,
    ),
  ),

  // Card Theme
  cardTheme: CardThemeData(
    color: AppColors.colorScheme.surface,
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),

  // Elevated Button Theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.colorScheme.primary,
      foregroundColor: AppColors.colorScheme.onPrimary,
      elevation: 2,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),

  // Outlined Button Theme
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.colorScheme.primary,
      side: BorderSide(color: AppColors.colorScheme.primary),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),

  // Text Button Theme
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.colorScheme.primary,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
  ),

  // Input Decoration Theme
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.colorScheme.surface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.colorScheme.outline),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.colorScheme.outline),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.colorScheme.primary, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.colorScheme.error),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  ),

  // Bottom Navigation Bar Theme
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.colorScheme.surface,
    selectedItemColor: AppColors.colorScheme.primary,
    unselectedItemColor: AppColors.colorScheme.onSurface.withOpacity(0.6),
    type: BottomNavigationBarType.fixed,
    elevation: 8,
  ),

  // Floating Action Button Theme
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.colorScheme.primary,
    foregroundColor: AppColors.colorScheme.onPrimary,
    elevation: 6,
  ),

  // Divider Theme
  dividerTheme: DividerThemeData(
    color: AppColors.colorScheme.outline,
    thickness: 1,
    space: 1,
  ),
);
