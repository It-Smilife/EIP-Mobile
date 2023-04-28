import 'package:flutter/cupertino.dart';
import 'eventModelTest.dart';

class EventProvider extends ChangeNotifier {
  final List<MyEvent> _events = [];

  List<MyEvent> get events => _events;

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void setDate(DateTime date) => _selectedDate = date;

  List<MyEvent> get eventsOfSelectedDate => _events;

  void addEvent(MyEvent event) {
    _events.add(event);

    notifyListeners();
  }
}
