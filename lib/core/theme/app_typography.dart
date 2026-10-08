import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Centralized Typography configuration for FastDO.
///
/// Follows Material 3 standard TextTheme naming with standardized font weights,
/// line heights, letter spacing, and dark/light color adaptations.
class AppTypography {
  AppTypography._();

  static const String? fontFamily = null;
  static const String monospaceFontFamily = 'monospace';

  /// Light TextTheme
  static TextTheme get lightTextTheme => _buildTextTheme(
    primaryColor: AppColors.textPrimaryLight,
    secondaryColor: AppColors.textSecondaryLight,
    tertiaryColor: AppColors.textTertiaryLight,
  );

  /// Dark TextTheme
  static TextTheme get darkTextTheme => _buildTextTheme(
    primaryColor: AppColors.textPrimaryDark,
    secondaryColor: AppColors.textSecondaryDark,
    tertiaryColor: AppColors.textTertiaryDark,
  );

  static TextTheme _buildTextTheme({
    required Color primaryColor,
    required Color secondaryColor,
    required Color tertiaryColor,
  }) {
    return TextTheme(
      // Display / Hero
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        color: primaryColor,
        letterSpacing: -1.0,
        height: 1.2,
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        color: primaryColor,
        letterSpacing: -0.8,
        height: 1.25,
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: primaryColor,
        letterSpacing: -0.6,
        height: 1.3,
      ),

      // Titles / Headers
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        color: primaryColor,
        letterSpacing: -0.5,
        height: 1.3,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: primaryColor,
        letterSpacing: -0.3,
        height: 1.35,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: primaryColor,
        letterSpacing: -0.2,
        height: 1.4,
      ),

      // Body text
      bodyLarge: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: primaryColor,
        letterSpacing: -0.1,
        height: 1.45,
      ),
      bodyMedium: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: secondaryColor,
        letterSpacing: 0,
        height: 1.5,
      ),
      bodySmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: tertiaryColor,
        letterSpacing: 0.1,
        height: 1.4,
      ),

      // Labels / Buttons / Badges
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: primaryColor,
        letterSpacing: 0.1,
        height: 1.2,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: secondaryColor,
        letterSpacing: 0.2,
        height: 1.2,
      ),
      labelSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: tertiaryColor,
        letterSpacing: 0.3,
        height: 1.2,
      ),
    );
  }

  /// Monospace code style helper for ADB commands, numbers, and technical IDs.
  static TextStyle code({
    double fontSize = 12.0,
    FontWeight fontWeight = FontWeight.w600,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: monospaceFontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: 0.2,
      height: 1.4,
    );
  }
}
