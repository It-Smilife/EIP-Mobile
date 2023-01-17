import 'package:flutter/cupertino.dart';
import 'package:itsmilife/pages/common/chat/model/chatMessageModel.dart';

class ChatUsers {
  String name;
  String LastMessage;
  String imageURL;
  String proID;
  String patientID;
  String time;
  ChatUsers(
      {required this.name,
      required this.LastMessage,
      required this.imageURL,
      required this.proID,
      required this.patientID,
      required this.time});
}
