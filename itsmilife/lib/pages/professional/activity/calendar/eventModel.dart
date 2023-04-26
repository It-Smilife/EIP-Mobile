import 'package:flutter/material.dart';

class Event {
  final String title;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String notes;

  Event({
    required this.title,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.notes,
  });
}
