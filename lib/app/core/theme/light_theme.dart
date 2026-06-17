import 'package:flutter/material.dart';
import 'package:sendx/app/core/theme/app_colors.dart';
import 'package:sendx/app/core/theme/base_theme.dart';
import 'package:sizer/sizer.dart';

class LightTheme extends BaseTheme {
  @override
  BottomNavigationBarThemeData get bottomNavigationBarThemeData =>
      BottomNavigationBarThemeData(
        selectedIconTheme: const IconThemeData(
          color: AppColors.cyan,
        ),
        unselectedIconTheme: const IconThemeData(
          color: AppColors.charcoal,
        ),
        selectedItemColor: AppColors.cyan,
        unselectedItemColor: AppColors.charcoal,
        selectedLabelStyle: TextStyle(
          color: AppColors.cyan,
          fontSize: 8.sp,
          fontWeight: FontWeight.w600,
        ),
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        unselectedLabelStyle: TextStyle(
          color: AppColors.charcoal,
          fontSize: 8.sp,
          fontWeight: FontWeight.w400,
        ),
      );

  @override
  FloatingActionButtonThemeData? get floatingActionButtonTheme =>
      ThemeData.light().floatingActionButtonTheme;

  @override
  InputDecorationTheme? get inputDecorationTheme => InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        iconColor: AppColors.muted,
        suffixIconColor: AppColors.muted,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.border,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.border,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.cyan,
            width: 1.4,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.coral,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.coral,
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.border,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        hintStyle: TextStyle(
          color: AppColors.muted.withOpacity(0.55),
          fontSize: 14,
          fontFamily: fontTheme.fontFamily,
          fontWeight: FontWeight.w400,
        ),
      );

  @override
  FontTheme get fontTheme => FontTheme(
        fontFamily: 'Poppins',
      );

  @override
  Color get scaffoldBackgroundColor => AppColors.surfaceSoft;

  @override
  ColorScheme get colorScheme => ColorScheme.fromSeed(
        seedColor: AppColors.cyan,
        primary: AppColors.cyan,
        secondary: AppColors.coral,
        surface: AppColors.surface,
        background: AppColors.surfaceSoft,
        error: AppColors.coral,
      );

  @override
  MaterialColor get primarySwatch => MaterialColor(0xFF12AEDD, {
        50: AppColors.cyan.withOpacity(0.1),
        100: AppColors.cyan.withOpacity(0.2),
        200: AppColors.cyan.withOpacity(0.3),
        300: AppColors.cyan.withOpacity(0.4),
        400: AppColors.cyan.withOpacity(0.5),
        500: AppColors.cyan,
        600: AppColors.cyan.withOpacity(0.6),
        700: AppColors.cyan.withOpacity(0.7),
        800: AppColors.cyan.withOpacity(0.8),
        900: AppColors.cyan.withOpacity(0.9),
      });

  /// dark theme swatch
  //  darkTheme: ThemeData(
  //   primarySwatch: MaterialColor(0xFF4791CE, {
  //     50: Color(0xFF4791CE).withOpacity(0.1),
  //     100: Color(0xFF4791CE).withOpacity(0.2),
  //     200: Color(0xFF4791CE).withOpacity(0.3),
  //     300: Color(0xFF4791CE).withOpacity(0.4),
  //     400: Color(0xFF4791CE).withOpacity(0.5),
  //     500: Color(0xFF4791CE), // Primary color for dark theme
  //     600: Color(0xFF4791CE).withOpacity(0.6),
  //     700: Color(0xFF4791CE).withOpacity(0.7),
  //     800: Color(0xFF4791CE).withOpacity(0.8),
  //     900: Color(0xFF4791CE).withOpacity(0.9),
  //   }),
  // ),
}
