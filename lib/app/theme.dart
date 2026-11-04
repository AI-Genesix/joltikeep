import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const background = Color(0xFF0E1120);
  static const surface = Color(0xFF171B2E);
  static const line = Color(0xFF262B47);
  static const text = Color(0xFFF2F3F8);
  static const muted = Color(0xFFA9AEC8);
  static const accent = Color(0xFFE8EBFF);

  // Couleurs pour tournois
  static const challenge = Color(0xFF4C8DFF);
  static const cup = Color(0xFFFF6B73);
  static const regional = Color(0xFFE8B33A);
  static const international = Color(0xFFB08CFF);

  // Couleurs pour historique matchs
  static const win = Color(0xFF3DDC84);
  static const tie = Color(0xFFFFD23F);
  static const loss = Color(0xFFFF6B6B);
}

ThemeData buildTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.dark(
      surface: AppColors.surface,
      primary: AppColors.accent,
      onSurface: AppColors.text,
    ),
  );
}
