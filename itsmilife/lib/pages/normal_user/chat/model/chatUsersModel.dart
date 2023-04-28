import 'package:flutter/cupertino.dart';
import 'package:itsmilife/pages/common/chat/model/chatMessageModel.dart';

class ChatUsers {
  String name;
  String LastMessage;
  String imageURL;
  String ID;
  String proID;
  String patientID;
  String time;
  ChatUsers(
      {required this.name,
      required this.LastMessage,
      required this.imageURL,
      required this.ID,
      required this.proID,
      required this.patientID,
      required this.time});
}

class UserPro {
  String username;
  String id;
  String imgURL;
  UserPro({required this.id, required this.username, required this.imgURL});
}

class UserPatient {
  String username;
  String id;
  String id_discussion;
  String imgURL;
  UserPatient({required this.id, required this.id_discussion, required this.username, required this.imgURL});
}
