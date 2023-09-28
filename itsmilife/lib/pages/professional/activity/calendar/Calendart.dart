import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:itsmilife/pages/common/settings/languageProvider.dart';
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
import 'package:itsmilife/pages/common/settings/darkModeProvider.dart';
import 'package:flutter_dash/flutter_dash.dart';

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
    final darkMode = Provider.of<DarkModeProvider>(context);
    final lang = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: darkMode.darkMode ? const Color.fromARGB(255, 58, 50, 83) : Colors.grey[200],
      appBar: AppBar(
        title: Text(
          lang.lang == "English" ? "Calendar" : "Calandrier",
          style: TextStyle(color: darkMode.darkMode ? Colors.white : Color.fromARGB(255, 98, 128, 182)),
        ),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          color: darkMode.darkMode ? Colors.white : Color.fromARGB(255, 98, 128, 182),
          icon: const Icon(CupertinoIcons.back),
          onPressed: () => {Navigator.pop(context)},
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Card(
            margin: EdgeInsets.only(right: 10, left: 10),
            elevation: 5,
            color: darkMode.darkMode ? Color.fromARGB(255, 45, 45, 45) : Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
              side: BorderSide(color: Colors.transparent, width: 2),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.76,
              // width: MediaQuery.of(context).size.width * 0.95,
              child: FutureBuilder(
                  future: _eventsFuture,
                  builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
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
                        headerHeight: 100,
                        // onViewChanged: (ViewChangedDetails viewChangedDetails) {
                        //   setState(() {
                        //     _isDayView = _controller.view == CalendarView.day;
                        //   });
                        // },
                        dataSource: EventDataSource(events),
                        appointmentTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
                        appointmentBuilder: (BuildContext context, CalendarAppointmentDetails calendarAppointmentDetails) {
                          final MyEvent event = calendarAppointmentDetails.appointments.first as MyEvent;
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
                        showNavigationArrow: false,
                        onTap: (calendarTapDetails) {
                          if (calendarTapDetails.date!.hour != 0 && calendarTapDetails.appointments != null) {
                            final event = calendarTapDetails.appointments![0] as MyEvent;
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0), // Définissez le rayon ici
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      event.title,
                                      style: TextStyle(fontSize: 25),
                                    ),
                                    const SizedBox(height: 20),
                                    const Dash(
                                      direction: Axis.horizontal,
                                      length: 250, // Prend la largeur de la carte
                                      dashLength: 15, // Longueur des traits du pointillé
                                      dashColor: Colors.grey, // Couleur des traits du pointillé
                                    ),
                                  ],
                                ),
                                content: SizedBox(
                                  width: double.maxFinite, // Largeur maximale disponible
                                  height: MediaQuery.of(context).size.height * 0.3, // Hauteur définie, ajustez en fonction de vos besoins
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start, // Alignement des éléments à gauche
                                      children: [
                                        Text('Début: ${event.start.hour}:${event.start.minute}\nFin: ${event.end.hour}:${event.end.minute}'),
                                        const SizedBox(height: 50),
                                        if (event.notes.isNotEmpty) // Vérifier si event.notes n'est pas vide
                                          const Text(
                                            "Notes",
                                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                          ),
                                        const SizedBox(height: 20),
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.9,
                                          height: MediaQuery.of(context).size.height * 0.15,
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Colors.deepPurpleAccent,
                                              width: 1.0,
                                            ),
                                          ),
                                          child: SingleChildScrollView(
                                            child: Text(
                                              event.notes,
                                              style: TextStyle(fontSize: 16.0),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(),
                                    child: const Text(
                                      'OK',
                                      style: TextStyle(color: Color.fromARGB(255, 97, 194, 101)),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      final isUpdated = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditEventPage(event: event),
                                        ),
                                      );
                                      if (isUpdated == true) {
                                        setState(() {
                                          events.clear();
                                          _eventsFuture = fetchEvents(events);
                                        });
                                      }
                                    },
                                    child: Text(
                                      lang.lang == "English" ? "edit" : 'éditer',
                                      style: TextStyle(color: Colors.deepPurpleAccent),
                                    ),
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
                                    child: Text(
                                      lang.lang == "English" ? "delete" : "supprimer",
                                      style: TextStyle(color: const Color.fromARGB(255, 250, 90, 79)),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else if (_controller.view == CalendarView.day && calendarTapDetails.appointments == null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddEvent(),
                              ),
                            );
                          }
                        },
                        timeSlotViewSettings: TimeSlotViewSettings(
                            startHour: 5,
                            endHour: 21,
                            nonWorkingDays: <int>[DateTime.friday, DateTime.saturday],
                            timeInterval: Duration(minutes: 60),
                            timeFormat: 'HH:mm',
                            timeIntervalHeight: 60,
                            timeTextStyle: TextStyle(color: darkMode.darkMode ? Colors.white : Color.fromARGB(255, 45, 45, 45))),
                        monthViewSettings: MonthViewSettings(
                          monthCellStyle: MonthCellStyle(textStyle: TextStyle(color: darkMode.darkMode ? Colors.white : Colors.grey)),
                          showAgenda: false,
                          appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
                          navigationDirection: MonthNavigationDirection.horizontal,
                          appointmentDisplayCount: 1,
                          dayFormat: 'EEE',
                          showTrailingAndLeadingDates: false,
                          numberOfWeeksInView: 5,
                        ),
                        cellBorderColor: darkMode.darkMode ? Color.fromARGB(255, 53, 53, 53) : Color.fromARGB(255, 239, 239, 239),
                        selectionDecoration: BoxDecoration(
                          color: Colors.deepPurple.withOpacity(0.3),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        todayHighlightColor: Colors.deepPurpleAccent,
                        headerStyle: CalendarHeaderStyle(
                          textStyle: TextStyle(
                            color: darkMode.darkMode ? Colors.grey : Colors.deepPurpleAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        viewHeaderStyle: ViewHeaderStyle(dayTextStyle: TextStyle(color: darkMode.darkMode ? Colors.white : Color.fromARGB(255, 45, 45, 45))),
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
        backgroundColor: darkMode.darkMode ? Color.fromARGB(255, 45, 45, 45) : Colors.deepPurpleAccent,
        hoverColor: Colors.purple,
        elevation: 5,
        child: const Icon(CupertinoIcons.add),
      ),
    );
  }
}
