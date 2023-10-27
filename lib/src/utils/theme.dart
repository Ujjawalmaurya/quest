import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Color _primaryColor = Colors.blue;
MaterialColor _primarySwatch = Colors.lightBlue;
Brightness _brightness = Brightness.light;
// Color _accentColor = Colors.yellow;

class QuestAppTheme {
  // PoSAppTheme._();

// ! LIGHT Theme

  static ThemeData lightTheme = ThemeData(
    // colorSchemeSeed: _primaryColor,
    // colorScheme: ColorScheme.fromSeed(
    //   seedColor: Colors.deepPurpleAccent,
    //   brightness: Brightness.light,
    // ),
    brightness: _brightness,
    primaryColor: _primaryColor,
    primarySwatch: _primarySwatch,
    useMaterial3: true,
    // cardTheme: CardTheme(
    //   elevation: 5,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadiusDirectional.circular(12),
    //   ),
    // ),
    appBarTheme: const AppBarTheme(
      // foregroundColor: Colors.white,
      centerTitle: true,
    ),
    dividerTheme: const DividerThemeData(indent: 10, endIndent: 10),
    // Elevated Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        elevation: const MaterialStatePropertyAll(5),
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        ),
        // foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        side: MaterialStatePropertyAll<BorderSide>(BorderSide(width: 2, color: _primarySwatch)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 14, horizontal: 22)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.grey.withOpacity(0.1),
      filled: true,
      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 22,
        horizontal: 26,
      ),
      // labelStyle: const TextStyle(
      //   fontSize: 45,
      //   decorationColor: Colors.red,
      // ),
      labelStyle: TextStyle(
        color: _primarySwatch,
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      circularTrackColor: Colors.amber,
    ),
  );

// !DARK theme
  static ThemeData darkTheme = ThemeData();
} //
