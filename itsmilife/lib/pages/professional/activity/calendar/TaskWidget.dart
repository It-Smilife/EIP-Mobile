import 'package:flutter/material.dart';
import 'package:itsmilife/pages/professional/activity/calendar/eventProvider.dart';
import 'package:provider/provider.dart';
import 'Calendart.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'calandarDataSource.dart';

class TaskWidget extends StatefulWidget {
  final DateTime? date;
  final List<dynamic>? event;
  const TaskWidget({Key? key, required this.date, required this.event})
      : super(key: key);
  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    return SfCalendarTheme(
      data: SfCalendarThemeData(),
      child: SfCalendar(
        view: CalendarView.day,
        initialDisplayDate: widget.date,
        dataSource: EventDataSource(provider.events),
      ),
    );
  }
}
