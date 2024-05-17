import 'package:flutter/material.dart';
import 'themes.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeData _currentTheme;
  bool _isDarkMode;

  ThemeNotifier(this._currentTheme, this._isDarkMode);

  ThemeData get currentTheme => _currentTheme;
  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    if (_isDarkMode) {
      _currentTheme = lightTheme;
    } else {
      _currentTheme = darkTheme;
    }
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
