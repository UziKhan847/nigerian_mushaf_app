import 'package:flutter/material.dart';

class MyThemes {
  static final ColorScheme lightScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 196, 54, 54),
    brightness: Brightness.light,
  );
  static final ColorScheme darkScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 196, 54, 54),
    brightness: Brightness.dark,
  );

  static ThemeData get lightTheme => ThemeData(
    colorScheme: lightScheme,
    brightness: Brightness.light,
    useMaterial3: true,
  );
  static ThemeData get darkTheme => ThemeData(
    colorScheme: darkScheme,
    brightness: Brightness.dark,
    useMaterial3: true,
  );
}
