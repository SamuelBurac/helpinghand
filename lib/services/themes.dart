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
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    floatingLabelStyle: const TextStyle(
      color: Colors.orange,
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.orange,
        width: 1.0,
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
      backgroundColor: WidgetStateProperty.all<Color>(Colors.orange),
      iconColor: WidgetStateProperty.all<Color>(Colors.black),
      textStyle: WidgetStateProperty.all<TextStyle>(const TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(30.0), // adjust the value as needed
        ),
      ),
    ),
  
  ),
  cardTheme: CardTheme(
    color: Colors.grey[200],
        shadowColor: Colors.black,
        elevation: 5,
        margin: const EdgeInsets.all(7),
        surfaceTintColor: Colors.orangeAccent.shade100,
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


/*
* Dark theme
*/
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
     elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
      backgroundColor: WidgetStateProperty.all<Color>(Colors.orange),
      textStyle: WidgetStateProperty.all<TextStyle>(const TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(30.0), // adjust the value as needed
        ),
      ),
    ),
  
  ),


  
    inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    floatingLabelStyle: const TextStyle(
      color: Colors.orange,
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.orange,
        width: 1.0,
      ),
    ),
  ),

cardTheme: CardTheme(
    color: Colors.grey[400],
        shadowColor: Colors.black,
        elevation: 5,
        margin: const EdgeInsets.all(7),
        surfaceTintColor: Colors.orange,
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
