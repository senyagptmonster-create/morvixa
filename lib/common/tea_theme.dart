import 'package:flutter/material.dart';

class TeaTheme {
  static const Color matchaGreen = Color(0xFF4A6B53);
  static const Color oolongAmber = Color(0xFFC27D38);
  static const Color parchment = Color(0xFFF9F6F0);
  static const Color darkBark = Color(0xFF232B25);
  static const Color warmGrey = Color(0xFFE8E4DC);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'AppFont',
      scaffoldBackgroundColor: parchment,
      colorScheme: const ColorScheme.light(
        primary: matchaGreen,
        secondary: oolongAmber,
        surface: Colors.white,
        onPrimary: Colors.white,
        onSurface: darkBark,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: matchaGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
    );
  }
}
