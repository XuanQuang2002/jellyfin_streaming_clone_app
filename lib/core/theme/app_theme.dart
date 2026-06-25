import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Jellyfin brand colors
class AppColors {
  AppColors._();

  // Primary — Jellyfin purple
  static const primary = Color(0xFFAA5CC3);
  static const primaryDark = Color(0xFF8B3DAF);
  static const primaryLight = Color(0xFFCC88E0);

  // Backgrounds
  static const backgroundDark = Color(0xFF101010);
  static const surfaceDark = Color(0xFF1C1C1E);
  static const cardDark = Color(0xFF2C2C2E);

  static const backgroundLight = Color(0xFFF2F2F7);
  static const surfaceLight = Color(0xFFFFFFFF);
  static const cardLight = Color(0xFFFFFFFF);

  // Text
  static const textPrimaryDark = Color(0xFFFFFFFF);
  static const textSecondaryDark = Color(0xFF8E8E93);
  static const textPrimaryLight = Color(0xFF000000);
  static const textSecondaryLight = Color(0xFF6C6C70);

  // Status
  static const error = Color(0xFFFF453A);
  static const success = Color(0xFF32D74B);
  static const warning = Color(0xFFFFD60A);
}

class AppTheme {
  AppTheme._();

  // ─── Material Dark Theme (Android) ───────────────────────────────────────

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.primaryLight,
        surface: AppColors.surfaceDark,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textPrimaryDark,
      ),
      scaffoldBackgroundColor: AppColors.backgroundDark,
      cardColor: AppColors.cardDark,
      cardTheme: CardThemeData(
        color: AppColors.cardDark,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundDark,
        foregroundColor: AppColors.textPrimaryDark,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: AppColors.textPrimaryDark,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
        ),
      ),
      textTheme: _darkTextTheme,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.cardDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        hintStyle: const TextStyle(
          color: AppColors.textSecondaryDark,
          fontSize: 16,
        ),
        labelStyle: const TextStyle(color: AppColors.textSecondaryDark),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
          elevation: 0,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.cardDark,
        thickness: 1,
        space: 1,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.cardDark,
        contentTextStyle: const TextStyle(color: AppColors.textPrimaryDark),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ─── Material Light Theme (Android) ──────────────────────────────────────

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.primaryDark,
        surface: AppColors.surfaceLight,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSurface: AppColors.textPrimaryLight,
      ),
      scaffoldBackgroundColor: AppColors.backgroundLight,
      cardColor: AppColors.cardLight,
      cardTheme: CardThemeData(
        color: AppColors.cardLight,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundLight,
        foregroundColor: AppColors.textPrimaryLight,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: AppColors.textPrimaryLight,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
        ),
      ),
      textTheme: _lightTextTheme,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFD1D1D6)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFD1D1D6)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        hintStyle: const TextStyle(
          color: AppColors.textSecondaryLight,
          fontSize: 16,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
          elevation: 0,
        ),
      ),
    );
  }

  // ─── Cupertino Theme (iOS) ────────────────────────────────────────────────

  static CupertinoThemeData get cupertinoTheme {
    return const CupertinoThemeData(
      primaryColor: AppColors.primary,
      brightness: Brightness.dark,
      barBackgroundColor: AppColors.backgroundDark,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      textTheme: CupertinoTextThemeData(
        primaryColor: AppColors.primary,
        // All TextStyles use inherit:false to match Cupertino's convention of
        // fully-resolved styles. Mixing inherit:true and inherit:false causes
        // "Failed to interpolate TextStyles with different inherit values"
        // during navigation bar route transitions.
        // decoration:none is also set here so the iOS underline fix is
        // baked in even when these styles are used directly.
        textStyle: TextStyle(
          inherit: false,
          color: AppColors.textPrimaryDark,
          fontSize: 16,
          fontFamily: '.SF Pro Text',
          decoration: TextDecoration.none,
        ),
        navTitleTextStyle: TextStyle(
          inherit: false,
          color: AppColors.textPrimaryDark,
          fontSize: 17,
          fontWeight: FontWeight.w600,
          fontFamily: '.SF Pro Text',
          decoration: TextDecoration.none,
        ),
        navLargeTitleTextStyle: TextStyle(
          inherit: false,
          color: AppColors.textPrimaryDark,
          fontSize: 34,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
          fontFamily: '.SF Pro Display',
          decoration: TextDecoration.none,
        ),
        navActionTextStyle: TextStyle(
          inherit: false,
          color: AppColors.primary,
          fontSize: 17,
          fontFamily: '.SF Pro Text',
          decoration: TextDecoration.none,
        ),
        tabLabelTextStyle: TextStyle(
          inherit: false,
          color: AppColors.textSecondaryDark,
          fontSize: 10,
          fontFamily: '.SF Pro Text',
          decoration: TextDecoration.none,
        ),
        actionTextStyle: TextStyle(
          inherit: false,
          color: AppColors.primary,
          fontSize: 17,
          fontFamily: '.SF Pro Text',
          decoration: TextDecoration.none,
        ),
        dateTimePickerTextStyle: TextStyle(
          inherit: false,
          color: AppColors.textPrimaryDark,
          fontSize: 21,
          fontFamily: '.SF Pro Display',
          decoration: TextDecoration.none,
        ),
        pickerTextStyle: TextStyle(
          inherit: false,
          color: AppColors.textPrimaryDark,
          fontSize: 21,
          fontFamily: '.SF Pro Display',
          decoration: TextDecoration.none,
        ),
      ),
    );
  }

  // ─── Text Themes ──────────────────────────────────────────────────────────

  static const TextTheme _darkTextTheme = TextTheme(
    displayLarge: TextStyle(
      color: AppColors.textPrimaryDark,
      fontSize: 57,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
      decoration: TextDecoration.none,
    ),
    displayMedium: TextStyle(
      color: AppColors.textPrimaryDark,
      fontSize: 45,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
      decoration: TextDecoration.none,
    ),
    headlineLarge: TextStyle(
      color: AppColors.textPrimaryDark,
      fontSize: 32,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.3,
      decoration: TextDecoration.none,
    ),
    headlineMedium: TextStyle(
      color: AppColors.textPrimaryDark,
      fontSize: 24,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.2,
      decoration: TextDecoration.none,
    ),
    headlineSmall: TextStyle(
      color: AppColors.textPrimaryDark,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.none,
    ),
    titleLarge: TextStyle(
      color: AppColors.textPrimaryDark,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.none,
    ),
    titleMedium: TextStyle(
      color: AppColors.textPrimaryDark,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      decoration: TextDecoration.none,
    ),
    titleSmall: TextStyle(
      color: AppColors.textSecondaryDark,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      decoration: TextDecoration.none,
    ),
    bodyLarge: TextStyle(
      color: AppColors.textPrimaryDark,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.none,
    ),
    bodyMedium: TextStyle(
      color: AppColors.textPrimaryDark,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.none,
    ),
    bodySmall: TextStyle(
      color: AppColors.textSecondaryDark,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.none,
    ),
    labelLarge: TextStyle(
      color: AppColors.textPrimaryDark,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.none,
    ),
    labelSmall: TextStyle(
      color: AppColors.textSecondaryDark,
      fontSize: 11,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      decoration: TextDecoration.none,
    ),
  );

  static const TextTheme _lightTextTheme = TextTheme(
    displayLarge: TextStyle(
      color: AppColors.textPrimaryLight,
      fontSize: 57,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
      decoration: TextDecoration.none,
    ),
    headlineLarge: TextStyle(
      color: AppColors.textPrimaryLight,
      fontSize: 32,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.3,
      decoration: TextDecoration.none,
    ),
    headlineMedium: TextStyle(
      color: AppColors.textPrimaryLight,
      fontSize: 24,
      fontWeight: FontWeight.w700,
      decoration: TextDecoration.none,
    ),
    headlineSmall: TextStyle(
      color: AppColors.textPrimaryLight,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.none,
    ),
    titleLarge: TextStyle(
      color: AppColors.textPrimaryLight,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.none,
    ),
    titleMedium: TextStyle(
      color: AppColors.textPrimaryLight,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      decoration: TextDecoration.none,
    ),
    titleSmall: TextStyle(
      color: AppColors.textSecondaryLight,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      decoration: TextDecoration.none,
    ),
    bodyLarge: TextStyle(
      color: AppColors.textPrimaryLight,
      fontSize: 16,
      decoration: TextDecoration.none,
    ),
    bodyMedium: TextStyle(
      color: AppColors.textPrimaryLight,
      fontSize: 14,
      decoration: TextDecoration.none,
    ),
    bodySmall: TextStyle(
      color: AppColors.textSecondaryLight,
      fontSize: 12,
      decoration: TextDecoration.none,
    ),
    labelLarge: TextStyle(
      color: AppColors.textPrimaryLight,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.none,
    ),
    labelSmall: TextStyle(
      color: AppColors.textSecondaryLight,
      fontSize: 11,
      fontWeight: FontWeight.w500,
      decoration: TextDecoration.none,
    ),
  );
}
