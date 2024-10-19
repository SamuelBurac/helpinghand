// lib/services/ThemeProvider.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  static const String _themeKey = 'theme_mode';
  SharedPreferences? _prefs;
  ThemeMode _themeMode = ThemeMode.system;  // Default value

  final ThemeData lightTheme;
  final ThemeData darkTheme;

  ThemeMode get themeMode => _themeMode;

  ThemeProvider({
    required this.lightTheme,
    required this.darkTheme,
  }) {
    _initPrefs();
  }

  // Initialize SharedPreferences
  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    if (_prefs != null) {
      String? themeModeString = _prefs!.getString(_themeKey);
      _themeMode = _parseThemeMode(themeModeString);
      notifyListeners();
    }
  }

  ThemeMode _parseThemeMode(String? themeModeString) {
    switch (themeModeString) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
    
    String themeModeString;
    switch (mode) {
      case ThemeMode.light:
        themeModeString = 'light';
        break;
      case ThemeMode.dark:
        themeModeString = 'dark';
        break;
      case ThemeMode.system:
        themeModeString = 'system';
        break;
    }
    
    await _prefs?.setString(_themeKey, themeModeString);
  }

  ThemeData getCurrentTheme(BuildContext context) {
    if (_themeMode == ThemeMode.system) {
      return MediaQuery.platformBrightnessOf(context) == Brightness.dark
          ? darkTheme
          : lightTheme;
    }
    return _themeMode == ThemeMode.dark ? darkTheme : lightTheme;
  }
}