import 'package:flutter/material.dart';

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
          color: Colors.black,
          fontFamily: fontTheme.fontFamily,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontFamily: fontTheme.fontFamily,
        ),
        bodySmall: TextStyle(
          fontSize: 14,
          color: Colors.black,
          fontFamily: fontTheme.fontFamily,
        ),
        titleLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
          fontFamily: fontTheme.fontFamily,
        ),
        displayLarge: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: fontTheme.fontFamily,
        ),
        displayMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: fontTheme.fontFamily,
        ),
        displaySmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: fontTheme.fontFamily,
        ),
        headlineLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: fontTheme.fontFamily,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: fontTheme.fontFamily,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: fontTheme.fontFamily,
        ),
        labelLarge: TextStyle(
          fontSize: 18,
          color: Colors.grey,
          fontFamily: fontTheme.fontFamily,
        ),
        labelMedium: TextStyle(
          fontSize: 16,
          color: Colors.grey,
          fontFamily: fontTheme.fontFamily,
        ),
        labelSmall: TextStyle(
          fontSize: 14,
          color: Colors.grey,
          fontFamily: fontTheme.fontFamily,
        ),
        titleMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
          fontFamily: fontTheme.fontFamily,
        ),
        titleSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
          fontFamily: fontTheme.fontFamily,
        ),
      );

  ThemeData get themeData => ThemeData(
        fontFamily: fontTheme.fontFamily,
        brightness: brightness,
        useMaterial3: false,
        primaryColor: const Color(0xFF4791CE),
        primarySwatch: primarySwatch,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        floatingActionButtonTheme: floatingActionButtonTheme,
        textTheme: textTheme,
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Color(0xFF4791CE),
          circularTrackColor: Color(0xFFE2E2E2),
          linearTrackColor: Color(0xFFE2E2E2),
          linearMinHeight: 4.0,
        ),
        bottomNavigationBarTheme: bottomNavigationBarThemeData,
        inputDecorationTheme: inputDecorationTheme,
        colorScheme: colorScheme,
        datePickerTheme: const DatePickerThemeData(
          headerBackgroundColor: Color(0xFF4791CE),
          headerForegroundColor: Colors.black,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.black,
        ),
      );
}

class FontTheme {
  final String fontFamily;

  FontTheme({required this.fontFamily});
}
