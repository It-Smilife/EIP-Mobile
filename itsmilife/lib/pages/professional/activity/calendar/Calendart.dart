import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:itsmilife/pages/common/settings/settings.dart';
import 'package:itsmilife/pages/professional/activity/calendar/TaskWidget.dart';
import 'package:itsmilife/pages/professional/activity/calendar/addEventPage.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'eventModelTest.dart';
import 'eventProvider.dart';
import 'calandarDataSource.dart';
import 'editEventPage.dart';
import 'fetchEvents.dart';
import 'deleteEvent.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final todaysDate = DateTime.now();
  DateTime? selectedCalendarDate;
  final CalendarController _controller = CalendarController();
  List<MyEvent> events = [];
  late Future<void> _eventsFuture;
  // bool _isDayView = false;

  @override
  void initState() {
    selectedCalendarDate = DateTime.now();
    initializeDateFormatting('fr_FR', null);
    _eventsFuture = fetchEvents(events);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final eventsProvider = Provider.of<EventProvider>(context).events;
    final provider = Provider.of<EventProvider>(context, listen: false);
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
              child: FutureBuilder(
                  future: _eventsFuture,
                  builder:
                      (BuildContext context, AsyncSnapshot<void> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return SfCalendar(
                        view: CalendarView.month,
                        allowedViews: const <CalendarView>[
                          CalendarView.month,
                          CalendarView.day,
                          CalendarView.week,
                        ],
                        controller: _controller,
                        firstDayOfWeek: 1,
                        allowViewNavigation: true,
                        showDatePickerButton: true,
                        initialSelectedDate: selectedCalendarDate,
                        // onViewChanged: (ViewChangedDetails viewChangedDetails) {
                        //   setState(() {
                        //     _isDayView = _controller.view == CalendarView.day;
                        //   });
                        // },
                        dataSource: EventDataSource(events),
                        appointmentTextStyle:
                            const TextStyle(color: Colors.white, fontSize: 20),
                        appointmentBuilder: (BuildContext context,
                            CalendarAppointmentDetails
                                calendarAppointmentDetails) {
                          final MyEvent event = calendarAppointmentDetails
                              .appointments.first as MyEvent;
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: event.backgroundColor,
                            ),
                            child: Center(
                              child: Text(
                                event.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          );
                        },
                        showNavigationArrow: true,
                        onTap: (calendarTapDetails) {
                          if (calendarTapDetails.date!.hour != 0 &&
                              calendarTapDetails.appointments != null) {
                            final event =
                                calendarTapDetails.appointments![0] as MyEvent;
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(event.title),
                                content: Text(
                                    'Début: ${event.start.hour}:${event.start.minute}\nFin: ${event.end.hour}:${event.end.minute}'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('OK'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      final isUpdated = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EditEventPage(event: event),
                                        ),
                                      );
                                      if (isUpdated == true) {
                                        setState(() {
                                          events.clear();
                                          _eventsFuture = fetchEvents(events);
                                        });
                                      }
                                    },
                                    child: const Text('edit'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await deleteEvent(event.id);
                                      setState(() {
                                        events.clear();
                                        _eventsFuture = fetchEvents(events);
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: const Text('delete'),
                                  ),
                                ],
                              ),
                            );
                          } else if (_controller.view == CalendarView.day &&
                              calendarTapDetails.appointments == null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddEvent(),
                              ),
                            );
                          }
                        },
                        timeSlotViewSettings: const TimeSlotViewSettings(
                          startHour: 5,
                          endHour: 21,
                          nonWorkingDays: <int>[
                            DateTime.friday,
                            DateTime.saturday
                          ],
                          timeInterval: Duration(minutes: 60),
                          timeFormat: 'HH:mm',
                          timeIntervalHeight: 60,
                        ),
                        monthViewSettings: const MonthViewSettings(
                          showAgenda: false,
                          appointmentDisplayMode:
                              MonthAppointmentDisplayMode.indicator,
                          navigationDirection:
                              MonthNavigationDirection.horizontal,
                          appointmentDisplayCount: 1,
                          dayFormat: 'EEE',
                          showTrailingAndLeadingDates: false,
                          // numberOfWeeksInView: 5,
                        ),
                        cellBorderColor: Color.fromARGB(255, 239, 239, 239),
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
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? eventAdded = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEvent(),
            ),
          );

          if (eventAdded == true) {
            setState(() {
              events.clear();
              _eventsFuture = fetchEvents(events);
            });
          }
        },
        backgroundColor: Colors.deepPurpleAccent,
        hoverColor: Colors.purple,
        elevation: 5,
        child: const Icon(CupertinoIcons.add),
      ),
    );
  }
}
