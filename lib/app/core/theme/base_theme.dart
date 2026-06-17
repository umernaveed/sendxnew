import 'package:flutter/material.dart';
import 'package:sendx/app/core/theme/app_colors.dart';

abstract class BaseTheme {
  FontTheme get fontTheme;
  Color get scaffoldBackgroundColor;
  Brightness get brightness => Brightness.light;
  FloatingActionButtonThemeData? get floatingActionButtonTheme;
  BottomNavigationBarThemeData get bottomNavigationBarThemeData;
  InputDecorationTheme? get inputDecorationTheme;
  ColorScheme? get colorScheme => const ColorScheme.light();
  MaterialColor get primarySwatch;

  TextTheme get textTheme => TextTheme(
        bodyLarge: TextStyle(
          fontSize: 18,
          color: AppColors.ink,
          fontFamily: fontTheme.fontFamily,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          color: AppColors.ink,
          fontFamily: fontTheme.fontFamily,
        ),
        bodySmall: TextStyle(
          fontSize: 14,
          color: AppColors.ink,
          fontFamily: fontTheme.fontFamily,
        ),
        titleLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.cyan,
          fontFamily: fontTheme.fontFamily,
        ),
        displayLarge: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: AppColors.ink,
          fontFamily: fontTheme.fontFamily,
        ),
        displayMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.ink,
          fontFamily: fontTheme.fontFamily,
        ),
        displaySmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.ink,
          fontFamily: fontTheme.fontFamily,
        ),
        headlineLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.ink,
          fontFamily: fontTheme.fontFamily,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.ink,
          fontFamily: fontTheme.fontFamily,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.ink,
          fontFamily: fontTheme.fontFamily,
        ),
        labelLarge: TextStyle(
          fontSize: 18,
          color: AppColors.muted,
          fontFamily: fontTheme.fontFamily,
        ),
        labelMedium: TextStyle(
          fontSize: 16,
          color: AppColors.muted,
          fontFamily: fontTheme.fontFamily,
        ),
        labelSmall: TextStyle(
          fontSize: 14,
          color: AppColors.muted,
          fontFamily: fontTheme.fontFamily,
        ),
        titleMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.cyan,
          fontFamily: fontTheme.fontFamily,
        ),
        titleSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.cyan,
          fontFamily: fontTheme.fontFamily,
        ),
      );

  ThemeData get themeData => ThemeData(
        fontFamily: fontTheme.fontFamily,
        brightness: brightness,
        useMaterial3: true,
        primaryColor: AppColors.cyan,
        primarySwatch: primarySwatch,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        floatingActionButtonTheme: floatingActionButtonTheme,
        textTheme: textTheme,
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.cyan,
          circularTrackColor: AppColors.border,
          linearTrackColor: AppColors.border,
          linearMinHeight: 4.0,
        ),
        bottomNavigationBarTheme: bottomNavigationBarThemeData,
        inputDecorationTheme: inputDecorationTheme,
        colorScheme: colorScheme,
        datePickerTheme: const DatePickerThemeData(
          headerBackgroundColor: AppColors.cyan,
          headerForegroundColor: Colors.white,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.cyan,
        ),
      );
}

class FontTheme {
  final String fontFamily;

  FontTheme({required this.fontFamily});
}
