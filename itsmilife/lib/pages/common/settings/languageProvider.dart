import 'package:flutter/material.dart';

String lang = " Français";

class LanguageProvider extends ChangeNotifier {
  String _lang = "Français";

  String get lang => _lang;

  set lang(String value) {
    _lang = value;
    notifyListeners();
  }
}