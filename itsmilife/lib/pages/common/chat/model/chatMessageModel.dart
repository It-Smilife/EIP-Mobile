import 'dart:ffi';

import 'package:flutter/cupertino.dart';

class ChatMessagee {
  String message;
  String date;
  String id;
  bool isSentByUser;
  ChatMessagee({required this.message, required this.isSentByUser, required this.date, required this.id});
}
