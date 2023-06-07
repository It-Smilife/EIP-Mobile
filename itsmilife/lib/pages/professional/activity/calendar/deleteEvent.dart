import 'package:flutter/material.dart';
import 'package:intl/date_symbols.dart';
import 'package:itsmilife/pages/common/profile.dart';
import 'package:itsmilife/services/NetworkManager.dart';
import 'eventModelTest.dart';
import 'package:itsmilife/pages/register.dart';

Future<void> deleteEvent(String eventId) async {
  try {
    final response = await NetworkManager.delete('appointments/' + eventId.toString());
    if (response.data['success']) {
      // La suppression a réussi, vous pouvez gérer la logique ici, par exemple, mettre à jour la liste des événements
      print('Event deleted successfully');
    } else {
      // La suppression a échoué, vous pouvez gérer les erreurs ici
      print('Failed to delete the event');
    }
  } catch (e) {
    // Gestion des exceptions et des erreurs
    print('Error: $e');
  }
}