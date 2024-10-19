// lib/services/notification_provider.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum NotificationFrequency { immediate, daily, disabled }

class NotificationPreferences with ChangeNotifier {
  static const String _inAppKey = 'in_app_messages';
  static const String _newJobFreqKey = 'new_job_frequency';
  static const String _newPersonFreqKey = 'new_person_frequency';

  SharedPreferences? _prefs;

  // Default values
  bool _inAppMessages = true;
  NotificationFrequency _newJobFrequency = NotificationFrequency.immediate;
  NotificationFrequency _newPersonFrequency = NotificationFrequency.immediate;

  // Getters
  bool get inAppMessages => _inAppMessages;
  NotificationFrequency get newJobFrequency => _newJobFrequency;
  NotificationFrequency get newPersonFrequency => _newPersonFrequency;

  NotificationPreferences() {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    await _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    if (_prefs != null) {
      _inAppMessages = _prefs!.getBool(_inAppKey) ?? true;
      _newJobFrequency = _parseFrequency(_prefs!.getString(_newJobFreqKey));
      _newPersonFrequency =
          _parseFrequency(_prefs!.getString(_newPersonFreqKey));
      notifyListeners();
    }
  }

  NotificationFrequency _parseFrequency(String? value) {
    switch (value) {
      case 'immediate':
        return NotificationFrequency.immediate;
      case 'daily':
        return NotificationFrequency.daily;
      case 'disabled':
        return NotificationFrequency.disabled;
      default:
        return NotificationFrequency.immediate;
    }
  }

  String _frequencyToString(NotificationFrequency freq) {
    switch (freq) {
      case NotificationFrequency.immediate:
        return 'immediate';
      case NotificationFrequency.daily:
        return 'daily';
      case NotificationFrequency.disabled:
        return 'disabled';
    }
  }

  Future<void> setInAppMessages(bool value) async {
    _inAppMessages = value;
    await _prefs?.setBool(_inAppKey, value);
    notifyListeners();
  }

  Future<void> setNewJobFrequency(NotificationFrequency freq) async {
    _newJobFrequency = freq;
    await _prefs?.setString(_newJobFreqKey, _frequencyToString(freq));
    notifyListeners();
  }

  Future<void> setNewPersonFrequency(NotificationFrequency freq) async {
    _newPersonFrequency = freq;
    await _prefs?.setString(_newPersonFreqKey, _frequencyToString(freq));
    notifyListeners();
  }
}
