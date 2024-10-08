import 'package:flutter/material.dart';

class ColorTheme {
  static final _kColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 33, 150, 243),
  );

  // static final _kDarkColorScheme = ColorScheme.fromSeed(
  //   brightness: Brightness.dark,
  //   seedColor: const Color.fromARGB(1, 1, 1, 1),
  // );

  static ThemeData fetchColorScheme() {
    return ThemeData(useMaterial3: true).copyWith(
      textTheme: const TextTheme().copyWith(
          headlineMedium: TextStyle(
            color: _kColorScheme.onPrimary,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          labelMedium: TextStyle(
            color: _kColorScheme.secondary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          labelSmall: TextStyle(
            color: _kColorScheme.error,
            fontSize: 14,
            fontWeight: FontWeight.normal,
          )),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: _kColorScheme.surface,
          backgroundColor: _kColorScheme.primary,
          minimumSize: const Size(250, 40),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
