import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:itsmilife/pages/normal_user/homepage/cardData.dart';
import 'package:itsmilife/pages/professional/activity/calendar/testaddenvnt.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:itsmilife/pages/professional/activity/calendar/addEventPage.dart';
import 'package:itsmilife/pages/professional/activity/calendar/eventModel.dart';
import 'package:collection/collection.dart';

typedef AddEventCallback = Function(String title, DateTime date,
    TimeOfDay startTime, TimeOfDay endDay, String notes);

class Calendar extends StatefulWidget {
  final Map<DateTime, List<Event>> eventList;

  const Calendar({Key? key, required this.eventList}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final todaysDate = DateTime.now();
  var _focusedCalendarDate = DateTime.now();
  final _initialCalendarDate = DateTime(2000);
  final _lastCalendarDate = DateTime(2050);
  DateTime? selectedCalendarDate;
  // Map<DateTime, List<Event>> events = {};
  // List<Event> eventList = [];
  Map<DateTime, List<Event>> eventMap = {};

  List<Event> events = [];

  void addEvent(String title, DateTime date, TimeOfDay startTime,
      TimeOfDay endTime, String notes) {
    setState(() {
      events.add(Event(
          title: title,
          date: date,
          startTime: startTime,
          endTime: endTime,
          notes: notes));
    });
    eventMap = _groupEventsByDate(events);
    eventMap.forEach((date, eventList) {
      print('Date: $date');
      print('Events:');
      eventList.forEach((event) {
        print('Title: ${event.title}, Date: ${event.date}');
      });
    });
  }

  Map<DateTime, List<Event>> _groupEventsByDate(List<Event> events) {
    Map<DateTime, List<Event>> eventMap = {};
    for (Event event in events) {
      DateTime eventDate =
          DateTime(event.date.year, event.date.month, event.date.day);
      eventMap[eventDate] = eventMap[eventDate] ?? [];
      eventMap[eventDate]!.add(event);
    }
    return eventMap;
  }

  List<Event> _getEventsForDay(DateTime day) {
    DateTime dateOnly = DateTime(day.year, day.month, day.day);
    print("huitre ${dateOnly}");
    return eventMap[dateOnly] ?? [];
  }

  @override
  void initState() {
    selectedCalendarDate = _focusedCalendarDate;
    // events = widget.eventList;
    // mySelectedEvents = {};
    super.initState();
  }

  // List<Event> _listOfDayEvents(DateTime dateTime) {
  //   return events[dateTime] ?? [];
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calendar',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          color: Colors.black,
          icon: const Icon(CupertinoIcons.back),
          onPressed: () => {Navigator.pop(context)},
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(height: 80),
          Card(
            margin: EdgeInsets.all(5),
            elevation: 5,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              side: BorderSide(color: Colors.transparent, width: 2),
            ),
            child: TableCalendar(
              focusedDay: _focusedCalendarDate,
              firstDay: _initialCalendarDate,
              lastDay: _lastCalendarDate,
              calendarFormat: CalendarFormat.month,
              weekendDays: const [DateTime.sunday, 6],
              startingDayOfWeek: StartingDayOfWeek.monday,
              daysOfWeekHeight: 100,
              rowHeight: 70,
              // eventLoader: (day) =>
              //     events.entries
              //         .where((event) => isSameDay(event.key, day))
              //         .map((event) => event.value).toList(),
              // locale: 'fr_FR',
              eventLoader: (day) {
                return _getEventsForDay(day);
              },
              headerStyle: const HeaderStyle(
                titleTextStyle: TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    // bottomLeft: Radius.circular(10),
                    // bottomRight: Radius.circular(10),
                  ),
                ),
                formatButtonTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                formatButtonDecoration: BoxDecoration(
                  color: Colors.deepPurpleAccent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                leftChevronIcon: Icon(
                  CupertinoIcons.left_chevron,
                  color: Colors.black,
                  size: 22,
                ),
                rightChevronIcon: Icon(
                  CupertinoIcons.right_chevron,
                  color: Colors.black,
                  size: 22,
                ),
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekendStyle: TextStyle(color: Colors.redAccent),
              ),
              calendarStyle: const CalendarStyle(
                weekendTextStyle: TextStyle(color: Colors.red),
                todayDecoration: BoxDecoration(
                  color: Colors.deepPurpleAccent,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Color.fromARGB(255, 140, 0, 255),
                  shape: BoxShape.circle,
                ),
                markerDecoration:
                    BoxDecoration(color: Colors.red, shape: BoxShape.circle),
              ),
              // calendarBuilders: CalendarBuilders(
              //   markerBuilder: (context, date, events) {
              //     if (events != null && events.isNotEmpty) {
              //       print("ok");
              //       return Positioned(
              //         right: 1,
              //         bottom: 1,
              //         child: Container(
              //           decoration: BoxDecoration(
              //             color: Colors.blue,
              //             shape: BoxShape.circle,
              //           ),
              //           child: Center(
              //             child: Text(
              //               '${events.length}',
              //               style: TextStyle(color: Colors.white),
              //             ),
              //           ),
              //         ),
              //       );
              //     }
              //     return null;
              //   },
              // ),
              selectedDayPredicate: (currentSelectedDate) {
                return (isSameDay(selectedCalendarDate!, currentSelectedDate));
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(selectedCalendarDate, selectedDay)) {
                  setState(() {
                    selectedCalendarDate = selectedDay;
                    _focusedCalendarDate = focusedDay;
                  });
                }
              },
            ),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TestEvnt(addEventCallback: addEvent),
            ),
          )
        },
        backgroundColor: Colors.deepPurpleAccent,
        hoverColor: Colors.purple,
        elevation: 5,
        child: const Icon(CupertinoIcons.add),
      ),
    );
  }
}
