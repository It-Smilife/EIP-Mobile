import 'package:flutter/material.dart';

import '../profile.dart';

class LanguageProvider extends ChangeNotifier {

  String get lang => ProfileData.language;

  set lang(String value) {
    ProfileData.language = value;
    notifyListeners();
  }
}