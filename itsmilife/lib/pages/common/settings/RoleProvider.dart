import 'package:flutter/material.dart';
import 'package:itsmilife/pages/common/profile.dart';

class RoleProvider extends ChangeNotifier {
  String get Setrole => ProfileData.role;


  set Setrole(String value) {
    ProfileData.role = value;
    notifyListeners();
  }
  
  bool get Setrolestate => ProfileData.rolestate;

  set Setrolestate(bool value) {
    ProfileData.rolestate = value;
    notifyListeners();
  }
}
