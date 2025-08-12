import 'package:flutter/material.dart';

// App Colors
class AppColors {
  // Primary Colors
  static const Color primaryLight = Color(0xFF2196F3);
  static const Color primaryDark = Color(0xFF1976D2);
  static const Color primaryVariantLight = Color(0xFF1976D2);
  static const Color primaryVariantDark = Color(0xFF1565C0);

  // Secondary Colors
  static const Color secondaryLight = Color(0xFF03DAC6);
  static const Color secondaryDark = Color(0xFF00BFA5);
  static const Color secondaryVariantLight = Color(0xFF018786);
  static const Color secondaryVariantDark = Color(0xFF008E76);

  // Background Colors
  static const Color backgroundLight = Color(0xFFFAFAFA);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E1E1E);

  // Text Colors
  static const Color onPrimaryLight = Color(0xFFFFFFFF);
  static const Color onPrimaryDark = Color(0xFF000000);
  static const Color onSecondaryLight = Color(0xFF000000);
  static const Color onSecondaryDark = Color(0xFFFFFFFF);
  static const Color onBackgroundLight = Color(0xFF000000);
  static const Color onBackgroundDark = Color(0xFFFFFFFF);
  static const Color onSurfaceLight = Color(0xFF000000);
  static const Color onSurfaceDark = Color(0xFFFFFFFF);

  // Error Colors
  static const Color errorLight = Color(0xFFB00020);
  static const Color errorDark = Color(0xFFCF6679);

  // Additional Colors
  static const Color disabledLight = Color(0xFFBDBDBD);
  static const Color disabledDark = Color(0xFF757575);
  static const Color dividerLight = Color(0xFFE0E0E0);
  static const Color dividerDark = Color(0xFF424242);
}

// Light Theme Color Scheme
ColorScheme _lightColorScheme = const ColorScheme(
  brightness: Brightness.light,
  primary: AppColors.primaryLight,
  onPrimary: AppColors.onPrimaryLight,
  primaryContainer: AppColors.primaryVariantLight,
  onPrimaryContainer: AppColors.onPrimaryLight,
  secondary: AppColors.secondaryLight,
  onSecondary: AppColors.onSecondaryLight,
  secondaryContainer: AppColors.secondaryVariantLight,
  onSecondaryContainer: AppColors.onSecondaryLight,
  tertiary: AppColors.secondaryLight,
  onTertiary: AppColors.onSecondaryLight,
  tertiaryContainer: AppColors.secondaryVariantLight,
  onTertiaryContainer: AppColors.onSecondaryLight,
  error: AppColors.errorLight,
  onError: AppColors.onPrimaryLight,
  errorContainer: AppColors.errorLight,
  onErrorContainer: AppColors.onPrimaryLight,
  background: AppColors.backgroundLight,
  onBackground: AppColors.onBackgroundLight,
  surface: AppColors.surfaceLight,
  onSurface: AppColors.onSurfaceLight,
  surfaceVariant: AppColors.surfaceLight,
  onSurfaceVariant: AppColors.onSurfaceLight,
  outline: AppColors.dividerLight,
  outlineVariant: AppColors.dividerLight,
  shadow: Color(0xFF000000),
  scrim: Color(0xFF000000),
  inverseSurface: AppColors.backgroundDark,
  onInverseSurface: AppColors.onBackgroundDark,
  inversePrimary: AppColors.primaryDark,
  surfaceTint: AppColors.primaryLight,
);

// Dark Theme Color Scheme
ColorScheme _darkColorScheme = const ColorScheme(
  brightness: Brightness.dark,
  primary: AppColors.primaryDark,
  onPrimary: AppColors.onPrimaryDark,
  primaryContainer: AppColors.primaryVariantDark,
  onPrimaryContainer: AppColors.onPrimaryDark,
  secondary: AppColors.secondaryDark,
  onSecondary: AppColors.onSecondaryDark,
  secondaryContainer: AppColors.secondaryVariantDark,
  onSecondaryContainer: AppColors.onSecondaryDark,
  tertiary: AppColors.secondaryDark,
  onTertiary: AppColors.onSecondaryDark,
  tertiaryContainer: AppColors.secondaryVariantDark,
  onTertiaryContainer: AppColors.onSecondaryDark,
  error: AppColors.errorDark,
  onError: AppColors.onPrimaryDark,
  errorContainer: AppColors.errorDark,
  onErrorContainer: AppColors.onPrimaryDark,
  background: AppColors.backgroundDark,
  onBackground: AppColors.onBackgroundDark,
  surface: AppColors.surfaceDark,
  onSurface: AppColors.onSurfaceDark,
  surfaceVariant: AppColors.surfaceDark,
  onSurfaceVariant: AppColors.onSurfaceDark,
  outline: AppColors.dividerDark,
  outlineVariant: AppColors.dividerDark,
  shadow: Color(0xFF000000),
  scrim: Color(0xFF000000),
  inverseSurface: AppColors.backgroundLight,
  onInverseSurface: AppColors.onBackgroundLight,
  inversePrimary: AppColors.primaryLight,
  surfaceTint: AppColors.primaryDark,
);

// Typography
TextTheme _textTheme = const TextTheme(
  displayLarge: TextStyle(
    fontSize: 57,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
    height: 1.12,
  ),
  displayMedium: TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.16,
  ),
  displaySmall: TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.22,
  ),
  headlineLarge: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.25,
  ),
  headlineMedium: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.29,
  ),
  headlineSmall: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.33,
  ),
  titleLarge: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.27,
  ),
  titleMedium: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    height: 1.5,
  ),
  titleSmall: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.43,
  ),
  bodyLarge: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.5,
  ),
  bodyMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.43,
  ),
  bodySmall: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.33,
  ),
  labelLarge: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.43,
  ),
  labelMedium: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.33,
  ),
  labelSmall: TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.45,
  ),
);

// Light Theme
ThemeData get lightTheme => ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: _lightColorScheme,
  textTheme: _textTheme,
  primaryTextTheme: _textTheme,

  // App Bar Theme
  appBarTheme: AppBarTheme(
    backgroundColor: _lightColorScheme.surface,
    foregroundColor: _lightColorScheme.onSurface,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: _textTheme.titleLarge?.copyWith(
      color: _lightColorScheme.onSurface,
    ),
  ),

  // Card Theme
  cardTheme: CardThemeData(
    color: _lightColorScheme.surface,
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),

  // Elevated Button Theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: _lightColorScheme.primary,
      foregroundColor: _lightColorScheme.onPrimary,
      elevation: 2,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),

  // Outlined Button Theme
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: _lightColorScheme.primary,
      side: BorderSide(color: _lightColorScheme.primary),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),

  // Text Button Theme
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: _lightColorScheme.primary,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
  ),

  // Input Decoration Theme
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: _lightColorScheme.surface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: _lightColorScheme.outline),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: _lightColorScheme.outline),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: _lightColorScheme.primary, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: _lightColorScheme.error),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  ),

  // Bottom Navigation Bar Theme
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: _lightColorScheme.surface,
    selectedItemColor: _lightColorScheme.primary,
    unselectedItemColor: _lightColorScheme.onSurface.withOpacity(0.6),
    type: BottomNavigationBarType.fixed,
    elevation: 8,
  ),

  // Floating Action Button Theme
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: _lightColorScheme.primary,
    foregroundColor: _lightColorScheme.onPrimary,
    elevation: 6,
  ),

  // Divider Theme
  dividerTheme: DividerThemeData(
    color: _lightColorScheme.outline,
    thickness: 1,
    space: 1,
  ),
);

// Dark Theme
ThemeData get darkTheme => ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: _darkColorScheme,
  textTheme: _textTheme,
  primaryTextTheme: _textTheme,

  // App Bar Theme
  appBarTheme: AppBarTheme(
    backgroundColor: _darkColorScheme.surface,
    foregroundColor: _darkColorScheme.onSurface,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: _textTheme.titleLarge?.copyWith(
      color: _darkColorScheme.onSurface,
    ),
  ),

  // Card Theme
  cardTheme: CardThemeData(
    color: _darkColorScheme.surface,
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),

  // Elevated Button Theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: _darkColorScheme.primary,
      foregroundColor: _darkColorScheme.onPrimary,
      elevation: 2,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),

  // Outlined Button Theme
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: _darkColorScheme.primary,
      side: BorderSide(color: _darkColorScheme.primary),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),

  // Text Button Theme
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: _darkColorScheme.primary,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
  ),

  // Input Decoration Theme
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: _darkColorScheme.surface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: _darkColorScheme.outline),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: _darkColorScheme.outline),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: _darkColorScheme.primary, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: _darkColorScheme.error),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  ),

  // Bottom Navigation Bar Theme
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: _darkColorScheme.surface,
    selectedItemColor: _darkColorScheme.primary,
    unselectedItemColor: _darkColorScheme.onSurface.withOpacity(0.6),
    type: BottomNavigationBarType.fixed,
    elevation: 8,
  ),

  // Floating Action Button Theme
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: _darkColorScheme.primary,
    foregroundColor: _darkColorScheme.onPrimary,
    elevation: 6,
  ),

  // Divider Theme
  dividerTheme: DividerThemeData(
    color: _darkColorScheme.outline,
    thickness: 1,
    space: 1,
  ),
);
