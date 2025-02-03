import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: const Color(0xFF3F51B5),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.indigo,
      brightness: Brightness.light,
    ).copyWith(secondary: const Color(0xFF2196F3)),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black87),
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF3F51B5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
      ),
    ),
    textTheme: const TextTheme(
      displaySmall: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(fontSize: 20),
      bodyMedium: TextStyle(fontSize: 16),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: const Color(0xFF3F51B5),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.indigo,
      brightness: Brightness.dark,
    ).copyWith(secondary: const Color(0xFF2196F3)),
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF3F51B5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
      ),
    ),
    textTheme: const TextTheme(
      displaySmall: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(fontSize: 20),
      bodyMedium: TextStyle(fontSize: 16),
    ),
  );
}
