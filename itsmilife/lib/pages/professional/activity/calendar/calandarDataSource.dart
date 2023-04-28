import 'package:flutter/material.dart';
import 'eventModelTest.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<MyEvent> appointments) {
    this.appointments = appointments;
  }

  MyEvent getEvent(int index) => appointments![index] as MyEvent;

  @override
  DateTime getStartTime(int index) => getEvent(index).start;

  @override
  DateTime getEndTime(int index) => getEvent(index).end;

  @override
  String getTitle(int index) => getEvent(index).title;

  @override
  String getNote(int index) => getEvent(index).notes;

  @override
  Color getColor(int index) => getEvent(index).backgroundColor;

  // @override
  // bool isAllDay(int index) => getEvent(index).isAllDay;
}
