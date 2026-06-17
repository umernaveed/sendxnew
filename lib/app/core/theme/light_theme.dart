import 'package:flutter/material.dart';
import 'package:sendx/app/core/theme/base_theme.dart';
import 'package:sizer/sizer.dart';

class LightTheme extends BaseTheme {
  @override
  BottomNavigationBarThemeData get bottomNavigationBarThemeData =>
      BottomNavigationBarThemeData(
        selectedIconTheme: const IconThemeData(
          color: Color(0xFF4791CE),
        ),
        unselectedIconTheme: const IconThemeData(
          color: Color(0xFF181725),
        ),
        selectedItemColor: const Color(0xFF4791CE),
        unselectedItemColor: const Color(0xFF181725),
        selectedLabelStyle: TextStyle(
          color: const Color(0xFF4791CE),
          fontSize: 8.sp,
          fontWeight: FontWeight.w600,
        ),
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        unselectedLabelStyle: TextStyle(
          color: const Color(0xFF181725),
          fontSize: 8.sp,
          fontWeight: FontWeight.w400,
        ),
      );

  @override
  FloatingActionButtonThemeData? get floatingActionButtonTheme =>
      ThemeData.light().floatingActionButtonTheme;

  @override
  InputDecorationTheme? get inputDecorationTheme => InputDecorationTheme(
        iconColor: Colors.grey,
        suffixIconColor: Colors.grey,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFE2E2E2),
            width: 1.0, // Border width
          ),
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFE2E2E2),
            width: 2.0, // Border width
          ),
        ),

        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        // Define the error border
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red, // Border color when in error state
            width: 1.0, // Border width when in error state
          ),
        ),
        // Define the disabled border
        disabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFE2E2E2), // Border color when disabled
            width: 1.0, // Border width when disabled
          ),
        ),

        hintStyle: TextStyle(
          color: const Color(0x337C7C7C),
          fontSize: 16,
          fontFamily: fontTheme.fontFamily,
          fontWeight: FontWeight.w400,
          height: 0.11,
        ),
      );

  @override
  FontTheme get fontTheme => FontTheme(
        fontFamily: 'Poppins',
      );

  @override
  Color get scaffoldBackgroundColor => Colors.white;

  @override
  MaterialColor get primarySwatch => MaterialColor(0xFF4791CE, {
        50: const Color(0xFF4791CE).withOpacity(0.1),
        100: const Color(0xFF4791CE).withOpacity(0.2),
        200: const Color(0xFF4791CE).withOpacity(0.3),
        300: const Color(0xFF4791CE).withOpacity(0.4),
        400: const Color(0xFF4791CE).withOpacity(0.5),
        500: const Color(0xFF4791CE), // Primary color
        600: const Color(0xFF4791CE).withOpacity(0.6),
        700: const Color(0xFF4791CE).withOpacity(0.7),
        800: const Color(0xFF4791CE).withOpacity(0.8),
        900: const Color(0xFF4791CE).withOpacity(0.9),
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
