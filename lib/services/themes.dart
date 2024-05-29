import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.orange,
  primaryColor: Colors.orange,
  visualDensity: VisualDensity.adaptivePlatformDensity,
   textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.orange,
      selectionHandleColor: Colors.orange,
    ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    displayMedium: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
    bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
      backgroundColor: WidgetStateProperty.all<Color>(Colors.orange),
      textStyle: WidgetStateProperty.all<TextStyle>(const TextStyle(
          fontSize: 12.5, fontWeight: FontWeight.bold, color: Colors.black)),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(30.0), // adjust the value as needed
        ),
      ),
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.orange,
    primaryColor: Colors.orange,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.orange,
      selectionHandleColor: Colors.orange,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontSize: 72.0, fontWeight: FontWeight.bold, color: Colors.white),
      displayMedium: TextStyle(
          fontSize: 35.0, fontWeight: FontWeight.bold, color: Colors.white),
      titleLarge: TextStyle(
          fontSize: 36.0, fontStyle: FontStyle.italic, color: Colors.white),
      bodyMedium:
          TextStyle(fontSize: 14.0, fontFamily: 'Hind', color: Colors.white),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
        backgroundColor: WidgetStateProperty.all<Color>(Colors.orange),
        textStyle: WidgetStateProperty.all<TextStyle>(const TextStyle(
            fontSize: 12.5, fontWeight: FontWeight.bold, color: Colors.black)),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(30.0), // adjust the value as needed
          ),
        ),
      ),
    ),
    colorScheme: const ColorScheme.dark().copyWith(surface: Colors.black));
