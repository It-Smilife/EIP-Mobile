import 'package:flutter/material.dart';
import 'package:itsmilife/pages/common/profile.dart';

class DarkModeProvider extends ChangeNotifier {

  bool get darkMode => ProfileData.dark;

  set darkMode(bool value) {
    ProfileData.dark = value;
    notifyListeners();
  }
}
