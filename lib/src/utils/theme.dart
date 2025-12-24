import 'package:flutter/material.dart';

class QuestAppTheme {
  // Light Theme Colors
  static const Color lightBg = Color(0xFFF8F9FE);
  static const Color lightSurface = Colors.white;
  static const Color lightPrimaryText = Color(0xFF1A1C1E);
  static const Color lightSecondaryText = Color(0xFF42474E);

  // Dark Theme Colors
  static const Color darkBg = Color(0xFF0F1115);
  static const Color darkSurface = Color(0xFF1B1E23);
  static const Color darkPrimaryText = Color(0xFFF1F1F1);
  static const Color darkSecondaryText = Color(0xFF9BA1A6);

  static ThemeData getTheme(Color accentColor, bool isDark) {
    final Color background = isDark ? darkBg : lightBg;
    final Color surface = isDark ? darkSurface : lightSurface;
    final Color primaryText = isDark ? darkPrimaryText : lightPrimaryText;
    final Color secondaryText = isDark ? darkSecondaryText : lightSecondaryText;

    return ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
      primaryColor: accentColor,
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: accentColor,
        brightness: isDark ? Brightness.dark : Brightness.light,
        background: background,
        surface: surface,
        onBackground: primaryText,
        onSurface: primaryText,
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: isDark ? darkSurface : accentColor,
        foregroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: isDark ? 2 : 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(color: primaryText, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(color: primaryText, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(color: primaryText),
        bodyMedium: TextStyle(color: secondaryText),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentColor,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: isDark ? Colors.white24 : Colors.black12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: accentColor, width: 2),
        ),
      ),
    );
  }

  static ThemeData lightTheme = getTheme(Colors.deepPurple, false);
  static ThemeData darkTheme = getTheme(Colors.deepPurple, true);
} //
