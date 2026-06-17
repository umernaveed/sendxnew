import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color cyan = Color(0xFF12AEDD);
  static const Color coral = Color(0xFFFF3F55);
  static const Color charcoal = Color(0xFF1F2024);
  static const Color ink = Color(0xFF101114);
  static const Color muted = Color(0xFF72757E);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceSoft = Color(0xFFF5FBFE);
  static const Color coralSoft = Color(0xFFFFEEF1);
  static const Color border = Color(0xFFE3EEF4);

  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      cyan,
      coral,
    ],
  );

  static const LinearGradient pageGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFEAF9FE),
      Color(0xFFFFF6F7),
      Color(0xFFFFFFFF),
    ],
    stops: [0, 0.48, 1],
  );
}
