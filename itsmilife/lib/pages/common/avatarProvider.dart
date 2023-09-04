import 'package:flutter/foundation.dart';
import 'package:itsmilife/pages/common/profile.dart';

class AvatarProvider extends ChangeNotifier {
  String _avatar = ProfileData.avatar;

  String get avatar => _avatar;

  void updateAvatar(String newAvatar) {
    _avatar = newAvatar;
    notifyListeners();
  }
}
