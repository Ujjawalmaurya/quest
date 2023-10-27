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
    // tabBarTheme: TabBarTheme(
    //   labelColor: _primaryColor,
    // ),
    // drawerTheme: const DrawerThemeData(
    //   elevation: 12,
    // ),
    // cardTheme: CardTheme(
    //   elevation: 5,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadiusDirectional.circular(12),
    //   ),
    // ),
    appBarTheme: const AppBarTheme(
      foregroundColor: Colors.white,
      centerTitle: true,
      // systemOverlayStyle: SystemUiOverlayStyle(
      //   statusBarColor: _primarySwatch,
      // systemNavigationBarContrastEnforced: true,
      // systemNavigationBarColor: _primaryColor,
      // systemNavigationBarDividerColor: Colors.yellowAccent,
      // ),
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
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        side: MaterialStatePropertyAll<BorderSide>(BorderSide(width: 2, color: _primarySwatch)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 12, horizontal: 20)),
      ),
    ),
    // inputDecorationTheme: InputDecorationTheme(
    //   suffixIconColor: Colors.blue.withOpacity(0.7),
    //   isDense: true,
    //   // activeIndicatorBorder: BorderSide(width: 2),
    //   border: InputBorder.none,
    //   outlineBorder: const BorderSide(width: 2, color: Colors.redAccent),
    //   // fillColor: Colors.grey,
    // ),
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
  );

// !DARK theme
  static ThemeData darkTheme = ThemeData();
} //
