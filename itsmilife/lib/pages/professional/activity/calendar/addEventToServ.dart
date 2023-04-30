import 'package:flutter/material.dart';
import 'package:itsmilife/pages/common/profile.dart';
import 'package:itsmilife/services/NetworkManager.dart';
import 'eventModelTest.dart';
import 'package:itsmilife/pages/register.dart';

Future<bool> addEvent({
  required String title,
  required DateTime start,
  required DateTime end,
  String? notes,
}) async {
  bool success = false;

  try {
    final response = await NetworkManager.post(
      'appointments',
      {
        "title": title,
        "start": start.toIso8601String(),
        "end": end.toIso8601String(),
        "notes": notes,
        "professional": ProfileData.id
      },
    );

    if (response.data['success'] == true) {
      success = true;
    }
  } catch (e) {
    print('Error in addEvent: $e');
  }

  return success;
}
