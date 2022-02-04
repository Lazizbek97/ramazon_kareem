import 'package:flutter/material.dart';

class MainTheme {
  static ThemeData light = ThemeData(
      fontFamily: 'WorkSans',
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          primary: Colors.red,
        ),
      ),
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      scaffoldBackgroundColor: const Color(0xffE1F3F6),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ));
}
