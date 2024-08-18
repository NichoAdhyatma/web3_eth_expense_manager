import 'package:flutter/material.dart';

class AppTheme {
  final ThemeData _baseTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    ),
  );

  ThemeData get lightTheme {
    return ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: _baseTheme.appBarTheme.copyWith(
        backgroundColor: Colors.grey[100],
      ),
      colorScheme: ColorScheme.light(
        primary: Colors.black,
        secondary: Colors.black,
        surface: Colors.grey[500]!,
      ),
      cardColor: Colors.grey[100],
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: _baseTheme.elevatedButtonTheme.style!.copyWith(
          backgroundColor: WidgetStatePropertyAll(Colors.grey[300]),
        ),
      ),
    );
  }

  ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      appBarTheme: _baseTheme.appBarTheme.copyWith(
        backgroundColor: Colors.black45,
      ),
      colorScheme: const ColorScheme.dark(
        primary: Colors.white,
        secondary: Colors.white,
        surface: Colors.black45,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: _baseTheme.elevatedButtonTheme.style!.copyWith(
          backgroundColor: const WidgetStatePropertyAll(Colors.black45),
        ),
      ),
      cardColor: Colors.black45,
    );
  }
}
