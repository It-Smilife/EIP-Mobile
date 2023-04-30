import 'package:flutter/material.dart';
import 'package:itsmilife/pages/common/profile.dart';
import 'package:itsmilife/pages/professional/activity/calendar/eventProvider.dart';
import 'package:itsmilife/services/NetworkManager.dart';
import 'eventModelTest.dart';
import 'package:itsmilife/pages/register.dart';

Future<List<MyEvent>> fetchEvents(List<MyEvent> eventsList) async {
  // Remplacez cette URL par l'URL de votre API
  final String apiUrl = 'appointments/professional/';
  final String userId = ProfileData.id;

  try {
    final response = await NetworkManager.get(apiUrl + userId);

    if (response.data['success'] == true) {
      List<dynamic> appointments = response.data['appointments'];

      for (var appointment in appointments) {
        eventsList.add(MyEvent(
          id: appointment['_id'],
          title: appointment['title'],
          notes: appointment['notes'],
          start: DateTime.parse(appointment['start']),
          end: DateTime.parse(appointment['end']),
          // backgroundColor: Colors.red,
        ));
      }
      return eventsList;
    } else {
      throw Exception('The API returned success as false.');
    }
  } catch (error) {
    throw Exception('Failed to load events: $error');
  }
}
