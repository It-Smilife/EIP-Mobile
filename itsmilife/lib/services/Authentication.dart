import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart' as http;

class Authenticate {
  Future signInFB() async {
    final LoginResult result = await FacebookAuth.instance.login(
      permissions: ['public_profile', 'email'],
    );
    if (result.status == LoginStatus.success) {
      final AccessToken accessToken = result.accessToken!;
      final userData = await FacebookAuth.instance.getUserData();
      print(userData);
      // userData.name
      // userData.email
      // userData.picture.data.url
    } else {
      print(result.status);
      print(result.message);
    }
  }

  Future isConnectedWithFB() async {
    final AccessToken? accessToken = await FacebookAuth.instance.accessToken;
      if (accessToken != null) {
        return 0;
      } else {
        return 1;  
      }
  }

  Future logOutFB() async {
    await FacebookAuth.instance.logOut();
  }
}