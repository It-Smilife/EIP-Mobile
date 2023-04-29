import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:itsmilife/pages/common/settings/settings.dart';
import 'package:itsmilife/pages/professional/activity/calendar/TaskWidget.dart';
import 'package:itsmilife/pages/professional/activity/calendar/addEventPage.dart';
import 'package:itsmilife/pages/professional/activity/calendar/testaddenvnt.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'eventModel.dart';
import 'eventModelTest.dart';
import 'eventProvider.dart';
import 'calandarDataSource.dart';

class TestCalendar extends StatefulWidget {
  final Map<DateTime, List<Event>> eventList;

  const TestCalendar({Key? key, required this.eventList}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<TestCalendar> {
  final todaysDate = DateTime.now();
  // var _focusedCalendarDate = DateTime.now();
  // final _initialCalendarDate = DateTime(2000);
  // final _lastCalendarDate = DateTime(2050);
  DateTime? selectedCalendarDate;
  Map<DateTime, List<Event>> eventMap = {};
  final CalendarController _controller = CalendarController();

  List<Event> events = [];

  @override
  void initState() {
    selectedCalendarDate = DateTime.now();
    initializeDateFormatting('fr_FR', null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final eventsProvider = Provider.of<EventProvider>(context).events;
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
          const SizedBox(height: 20),
          Card(
            margin: EdgeInsets.all(5),
            elevation: 5,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
              side: BorderSide(color: Colors.transparent, width: 2),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              // width: MediaQuery.of(context).size.width * 0.95,
              child: SfCalendar(
                view: CalendarView.month,
                allowedViews: <CalendarView>[
                  CalendarView.month,
                  CalendarView.day,
                  CalendarView.week,
                ],
                firstDayOfWeek: 1,
                allowViewNavigation: true,
                showDatePickerButton: true,
                initialSelectedDate: selectedCalendarDate,
                dataSource: EventDataSource(eventsProvider),
                showNavigationArrow: true,
  
                // onLongPress: (details) {
                //   final provider =
                //       Provider.of<EventProvider>(context, listen: false);

                //   provider.setDate(details.date!);

                //   showModalBottomSheet(
                //     context: context,
                //     builder: (context) => TaskWidget(
                //         date: details.date, event: details.appointments),
                //   );
                // },
                timeSlotViewSettings: const TimeSlotViewSettings(
                  startHour: 5,
                  endHour: 21,
                  nonWorkingDays: <int>[DateTime.friday, DateTime.saturday],
                  timeInterval: Duration(minutes: 60),
                  timeFormat: 'HH:mm',
                  timeIntervalHeight: 60,
                ),
                monthViewSettings: const MonthViewSettings(
                  showAgenda: false,
                  appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
                  navigationDirection: MonthNavigationDirection.horizontal,
                  appointmentDisplayCount: 1,
                  dayFormat: 'EEE',
                  showTrailingAndLeadingDates: false,
                  // numberOfWeeksInView: 5,
                ),
                cellBorderColor: Color.fromARGB(255, 204, 204, 204),
                selectionDecoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.3),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(4),
                ),
                todayHighlightColor: Colors.deepPurpleAccent,
                headerStyle: const CalendarHeaderStyle(
                  textStyle: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TestEvent(),
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
