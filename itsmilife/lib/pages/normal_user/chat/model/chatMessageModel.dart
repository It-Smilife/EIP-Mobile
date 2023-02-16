import 'package:flutter/cupertino.dart';

class ChatMessage {
  String message;
  String date;
  String id;
  String messageID;
  ChatMessage({required this.message, required this.messageID, required this.date, required this.id});
}
