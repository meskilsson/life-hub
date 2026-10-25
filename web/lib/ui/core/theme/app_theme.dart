import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static final light = ThemeData(
    useMaterial3: true,

    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary).copyWith(
      primary: AppColors.primary,
      onPrimary: Colors.black,
      secondary: AppColors.secondary,
      onSecondary: Colors.black,
      surface: Colors.white,
      onSurface: const Color(0xFF171717),
      onSurfaceVariant: const Color(0xFF525252),
      outline: const Color(0xFF737373),
      outlineVariant: const Color(0xFFE5E5E5),
    ),

    scaffoldBackgroundColor: const Color(0xFFF5F5F5),

    // Top navigation
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Color(0xFF171717),
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),

    // Text fields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      hoverColor: const Color(0x0A000000),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      labelStyle: const TextStyle(color: Color(0xFF525252)),
      suffixStyle: const TextStyle(color: Color(0xFF525252)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF737373)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
    ),

    // Primary action buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );
}
