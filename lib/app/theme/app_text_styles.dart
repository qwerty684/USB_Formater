import 'package:flutter/material.dart';
import 'package:usb_formater/app/theme/app_colors.dart';

class AppTextStyles {
  const AppTextStyles._();

  static TextTheme textTheme(ColorScheme colorScheme) {
    return TextTheme(
      displaySmall: _style(
        fontSize: 34,
        fontWeight: FontWeight.w800,
        height: 1.05,
        color: colorScheme.onSurface,
      ),
      headlineMedium: _style(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        height: 1.1,
        color: colorScheme.onSurface,
      ),
      titleLarge: _style(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: colorScheme.onSurface,
      ),
      titleMedium: _style(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: colorScheme.onSurface,
      ),
      titleSmall: _style(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: colorScheme.onSurface,
      ),
      bodyLarge: _style(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.45,
        color: colorScheme.onSurface,
      ),
      bodyMedium: _style(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.45,
        color: AppColors.textSecondary,
      ),
      bodySmall: _style(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.4,
        color: AppColors.textSecondary,
      ),
      labelLarge: _style(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: colorScheme.onSurface,
      ),
      labelMedium: _style(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        height: 1.2,
        color: AppColors.textSecondary,
      ),
    );
  }

  static TextStyle get heroTitle => _style(
    fontSize: 38,
    fontWeight: FontWeight.w800,
    height: 1,
    color: Colors.white,
    shadows: const [
      Shadow(color: Color(0x24000000), blurRadius: 20, offset: Offset(0, 8)),
    ],
  );

  static TextStyle get heroSubtitle => _style(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    height: 1.35,
    color: Colors.white,
  );

  static TextStyle get sectionTitle => _style(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle get cardTitle => _style(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle get cardSubtitle => _style(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static TextStyle get buttonLabel =>
      _style(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.white);

  static TextStyle get dialogTitle => _style(
    fontSize: 22,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  static TextStyle _style({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    double? height,
    List<Shadow>? shadows,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      shadows: shadows,
      fontFamilyFallback: const [
        'SF Pro Display',
        'SF Pro Text',
        'Segoe UI',
        'Inter',
        'Helvetica Neue',
        'Arial',
        'sans-serif',
      ],
    );
  }
}
