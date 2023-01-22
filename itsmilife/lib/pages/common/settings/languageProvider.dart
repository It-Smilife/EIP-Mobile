import 'package:flutter/material.dart';

String lang = "English";

class LanguageProvider extends ChangeNotifier {
  String _lang = "English";

  String get lang => _lang;

  set lang(String value) {
    _lang = value;
    notifyListeners();
  }
}