import 'package:flutter/material.dart';

// Right colors have not been set yet
class AppTheme {

  static Color? white1 = Colors.white;
  static Color? white2 = Colors.white;
  static Color? white3 = Colors.white;
  static const Color green = Color(0xFF5a9075);
  static const Color blue = Color(0xFF3772fe);
  static const Color darkGrey = Color(0xFF272727);


  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.blueAccent),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blueGrey[800],
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.blueAccent),
  );
}
