import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF3F51B5),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color(0xFF2196F3)),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black87),
      titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: const Color(0xFF3F51B5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: const TextTheme(
      displaySmall: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(fontSize: 20),
      bodyMedium: TextStyle(fontSize: 16),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF3F51B5),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color(0xFF2196F3)),
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: const Color(0xFF3F51B5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: const TextTheme(
      displayMedium: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(fontSize: 20),
      bodyMedium: TextStyle(fontSize: 16),
    ),
  );
}
