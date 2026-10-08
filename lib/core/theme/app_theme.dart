import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'app_typography.dart';

class AppTheme {
  static ThemeData lightTheme() {
    final textTheme = AppTypography.lightTextTheme;
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      textTheme: textTheme,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryGreenDark,
        brightness: Brightness.light,
        surface: const Color(0xFFFFFFFF),
        surfaceContainerHighest: const Color(0xFFF1F5F9),
      ),
      scaffoldBackgroundColor: AppColors.backgroundLight,
      cardTheme: const CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.softBorder,
          side: BorderSide(color: Color(0xFFE2E8F0), width: 0.8),
        ),
        color: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge,
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFFE2E8F0),
        thickness: 0.8,
        space: 1,
      ),
    );
  }

  static ThemeData darkTheme() {
    final textTheme = AppTypography.darkTextTheme;
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      textTheme: textTheme,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryGreen,
        brightness: Brightness.dark,
        surface: AppColors.surfaceDark,
        surfaceContainerHighest: AppColors.surfaceCardDark,
      ),
      scaffoldBackgroundColor: AppColors.backgroundDark,
      cardTheme: const CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.softBorder,
          side: BorderSide(color: Color(0xFF1F2937), width: 0.8),
        ),
        color: Color(0xFF161F30),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge,
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFF1F2937),
        thickness: 0.8,
        space: 1,
      ),
    );
  }
}
