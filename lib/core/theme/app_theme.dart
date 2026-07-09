import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vitali/core/constants/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    const colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary:          AppColors.brandMain,
      onPrimary:        AppColors.textOnGreen,
      primaryContainer: AppColors.successBg,
      onPrimaryContainer: AppColors.brandMid,
      secondary:        AppColors.brandTurquoise,
      onSecondary:      AppColors.textOnGreen,
      secondaryContainer: AppColors.infoPastel,
      onSecondaryContainer: AppColors.brandForest,
      surface:          AppColors.surface,
      onSurface:        AppColors.textPrimary,
      surfaceContainerHighest: AppColors.inputFill,
      error:            Color(0xFFBA1A1A),
      onError:          Color(0xFFFFFFFF),
      errorContainer:   Color(0xFFFFDAD6),
      onErrorContainer: Color(0xFF410002),
      outline:          AppColors.textHint,
      outlineVariant:   AppColors.inputFill,
    );

    final base = ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
    );

    return base.copyWith(
      textTheme: GoogleFonts.quicksandTextTheme(base.textTheme).apply(
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputFill,
        hintStyle: const TextStyle(
          color: AppColors.textHint,
          fontSize: 13,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.brandMain, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      ),
    );
  }
}
