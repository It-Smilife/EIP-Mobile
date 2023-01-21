import 'package:flutter/material.dart';

bool isDarkMode = false;

class DarkModeProvider extends ChangeNotifier {
  bool _darkMode = false;

  bool get darkMode => _darkMode;

  set darkMode(bool value) {
    _darkMode = value;
    notifyListeners();
  }
}
