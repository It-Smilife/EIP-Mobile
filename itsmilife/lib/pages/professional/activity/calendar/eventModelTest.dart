import 'package:flutter/material.dart';

class MyEvent {
  final String title;
  final String notes;
  final DateTime start;
  final DateTime end;
  final Color backgroundColor;
  // final bool isAllDay;

  const MyEvent(
      {required this.title,
      required this.notes,
      required this.start,
      required this.end,
      this.backgroundColor = Colors.red});
}
