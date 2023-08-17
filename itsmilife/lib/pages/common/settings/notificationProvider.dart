import 'package:flutter/material.dart';
import 'package:itsmilife/pages/common/profile.dart';

class NotificationProvider extends ChangeNotifier {
  bool _notif = false;

  bool get notif => _notif;

  set notif(bool value) {
    _notif = value;
    notifyListeners();
  }
}
