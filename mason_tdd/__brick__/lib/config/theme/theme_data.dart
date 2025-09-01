import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

// Color Scheme
ColorScheme _colorScheme = const ColorScheme(
  brightness: Brightness.light,
  primary: AppColors.primary,
  onPrimary: AppColors.onPrimary,
  primaryContainer: AppColors.primaryVariant,
  onPrimaryContainer: AppColors.onPrimary,
  secondary: AppColors.secondary,
  onSecondary: AppColors.onSecondary,
  secondaryContainer: AppColors.secondaryVariant,
  onSecondaryContainer: AppColors.onSecondary,
  tertiary: AppColors.secondary,
  onTertiary: AppColors.onSecondary,
  tertiaryContainer: AppColors.secondaryVariant,
  onTertiaryContainer: AppColors.onSecondary,
  error: AppColors.error,
  onError: AppColors.onPrimary,
  errorContainer: AppColors.error,
  onErrorContainer: AppColors.onPrimary,
  background: AppColors.background,
  onBackground: AppColors.onBackground,
  surface: AppColors.surface,
  onSurface: AppColors.onSurface,
  surfaceVariant: AppColors.surface,
  onSurfaceVariant: AppColors.onSurface,
  outline: AppColors.divider,
  outlineVariant: AppColors.divider,
  shadow: AppColors.shadow,
  scrim: AppColors.scrim,
  inverseSurface: AppColors.inverseSurface,
  onInverseSurface: AppColors.onInverseSurface,
  inversePrimary: AppColors.inversePrimary,
  surfaceTint: AppColors.primary,
);

// Theme
ThemeData get theme => ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: _colorScheme,
  textTheme: AppTextStyles.textTheme,
  primaryTextTheme: AppTextStyles.textTheme,

  // App Bar Theme
  appBarTheme: AppBarTheme(
    backgroundColor: _colorScheme.surface,
    foregroundColor: _colorScheme.onSurface,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: AppTextStyles.titleLarge.copyWith(
      color: _colorScheme.onSurface,
    ),
  ),

  // Card Theme
  cardTheme: CardThemeData(
    color: _colorScheme.surface,
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),

  // Elevated Button Theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: _colorScheme.primary,
      foregroundColor: _colorScheme.onPrimary,
      elevation: 2,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),

  // Outlined Button Theme
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: _colorScheme.primary,
      side: BorderSide(color: _colorScheme.primary),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),

  // Text Button Theme
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: _colorScheme.primary,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
  ),

  // Input Decoration Theme
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: _colorScheme.surface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: _colorScheme.outline),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: _colorScheme.outline),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: _colorScheme.primary, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: _colorScheme.error),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  ),

  // Bottom Navigation Bar Theme
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: _colorScheme.surface,
    selectedItemColor: _colorScheme.primary,
    unselectedItemColor: _colorScheme.onSurface.withOpacity(0.6),
    type: BottomNavigationBarType.fixed,
    elevation: 8,
  ),

  // Floating Action Button Theme
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: _colorScheme.primary,
    foregroundColor: _colorScheme.onPrimary,
    elevation: 6,
  ),

  // Divider Theme
  dividerTheme: DividerThemeData(
    color: _colorScheme.outline,
    thickness: 1,
    space: 1,
  ),
);
