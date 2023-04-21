import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:itsmilife/pages/normal_user/homepage/cardData.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final todaysDate = DateTime.now();
  var _focusedCalendarDate = DateTime.now();
  final _initialCalendarDate = DateTime(2000);
  final _lastCalendarDate = DateTime(2050);
  DateTime? selectedCalendarDate;

  @override
  void initState() {
    selectedCalendarDate = _focusedCalendarDate;
    // mySelectedEvents = {};
    super.initState();
  }

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
              // locale: 'fr_FR',
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
                      shape: BoxShape.circle)),
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
        onPressed: () => {},
        backgroundColor: Colors.deepPurpleAccent,
        hoverColor: Colors.purple,
        elevation: 5,
        child: const Icon(CupertinoIcons.add),
      ),
    );
  }
}
