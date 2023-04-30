import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:itsmilife/pages/common/profile.dart';
import 'package:itsmilife/pages/professional/activity/calendar/eventProvider.dart';
import 'package:itsmilife/services/NetworkManager.dart';
import 'eventModelTest.dart';
import 'package:itsmilife/pages/register.dart';

Future<void> updateEvent(String eventId, String title, DateTime start,
    DateTime end, String notes) async {
  try {
    final response = await NetworkManager.put("appointments/$eventId", {
      "title": title,
      "start": start.toIso8601String(),
      "end": end.toIso8601String(),
      "notes": notes,
    });
    if (response.data['success']) {
      // La mise à jour a réussi, vous pouvez gérer la logique ici, par exemple, mettre à jour la liste des événements
      print('Event updated successfully');
    } else {
      // La mise à jour a échoué, vous pouvez gérer les erreurs ici
      print('Failed to update the event');
    }
  } catch (e) {
    // Gestion des exceptions et des erreurs
    print('Error: $e');
  }
}
