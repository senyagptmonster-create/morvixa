import 'package:flutter/material.dart';

class MorvixaTheme {
  static const bg = Color(0xFFF6FAF7);
  static const surface = Color(0xFFFFFFFF);
  static const edge = Color(0xFFD2EBD9);
  static const accent = Color(0xFF15803D); // Tea Green
  static const accentLight = Color(0xFF4ADE80);
  static const amberTea = Color(0xFFB45309);
  static const ink = Color(0xFF14532D);
  static const muted = Color(0xFF4E735A);

  static ThemeData get themeData {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: bg,
      fontFamily: 'AppFont',
      primaryColor: accent,
      colorScheme: const ColorScheme.light(
        primary: accent,
        surface: surface,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: surface,
        elevation: 0,
        foregroundColor: ink,
        iconTheme: IconThemeData(color: ink),
      ),
    );
  }
}
