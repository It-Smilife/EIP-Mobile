import 'package:flutter/material.dart';

class MyEvent {
  final String id;
  final String title;
  final String notes;
  final DateTime start;
  final DateTime end;
  final String backgroundColor;
  // final bool isAllDay;

  const MyEvent({required this.title, required this.notes, required this.start, required this.end, required this.id, required this.backgroundColor});
}
