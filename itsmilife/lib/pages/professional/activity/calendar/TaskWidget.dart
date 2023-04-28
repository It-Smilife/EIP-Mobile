import 'package:flutter/material.dart';
import 'package:itsmilife/pages/professional/activity/calendar/eventProvider.dart';
import 'package:provider/provider.dart';
import 'testCalendart.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'calandarDataSource.dart';

class TaskWidget extends StatefulWidget {
  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    final selectedEvents = provider.eventsOfSelectedDate;


    if (selectedEvents.isEmpty) {
      return const Center(
        child: Text(
          'No Events found for this day.',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
      );
    }
    return SfCalendarTheme(
      data: SfCalendarThemeData(),
      child: SfCalendar(
        view: CalendarView.day,
        dataSource: EventDataSource(provider.events),
      ),
    );
  }
}
