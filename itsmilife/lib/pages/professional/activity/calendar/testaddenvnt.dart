import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:itsmilife/pages/common/settings/languageProvider.dart';
import 'package:provider/provider.dart';
import 'package:itsmilife/pages/professional/activity/calendar/eventModel.dart';
import 'package:collection/collection.dart';
import 'calendar.dart';

class TestEvnt extends StatefulWidget {
  final AddEventCallback addEventCallback;

  const TestEvnt({super.key, required this.addEventCallback});

  @override
  _AddEvent createState() => _AddEvent();
}

class _AddEvent extends State<TestEvnt> {
  final _titleCotroller = TextEditingController();
  final _notesController = TextEditingController();
  TimeOfDay _selectedTimeBegin = TimeOfDay.now();
  TimeOfDay _selectedTimeEnd = TimeOfDay.now();
  DateTime _selectedDate = DateTime.now();
  Map<DateTime, List<Event>> events = {};

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr_FR', null);
    // print(events.entries.length);
  }

  @override
  void dispose() {
    _titleCotroller.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void addEvent(String title, DateTime date, TimeOfDay startTime,
      TimeOfDay endTime, String notes) {
    Event newEvent = Event(
      title: title,
      date: date,
      startTime: startTime,
      endTime: endTime,
      notes: notes,
    );
    setState(() {
      if (events[date] != null) {
        events[date]!.add(newEvent);
      } else {
        events[date] = [newEvent];
      }
    });
    print(
        "events tab : ${events.entries.where((element) => element.key == date).map((e) => MapEntry(e.key, e.value))}");
    _titleCotroller.clear();
    _notesController.clear();
    Navigator.pop(context, events);
  }

  void _submitForm() {
    widget.addEventCallback(_titleCotroller.text, _selectedDate,
        _selectedTimeBegin, _selectedTimeEnd, _notesController.text);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final appBar = AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
    final lang = Provider.of<LanguageProvider>(context);
    DateTime _selectedDate = DateTime.now();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 246, 246, 246),
      appBar: appBar,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: MediaQuery.of(context).size.width * 0.10,
            right: 0,
            bottom: 0,
            child: Text(
              lang.lang == "English" ? "Add an Evend" : "Ajouter un évènement",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.normal),
            ),
          ),
          Positioned(
            top: appBar.preferredSize.height + 10,
            left: 5.0,
            right: 5.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 60,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      TextField(
                        controller: _titleCotroller,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(CupertinoIcons.pencil),
                          hintText: lang.lang == "English" ? "Title" : "Titre",
                        ),
                      ),
                      const SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: _selectedDate,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(Duration(days: 365)),
                          ).then((date) {
                            if (date != null) {
                              setState(() {
                                _selectedDate = date;
                              });
                            }
                          });
                        },
                        style: ButtonStyle(
                          // minimumSize: MaterialStateProperty.all<Size>(
                          //   const Size(150, 35),
                          // ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        child: SizedBox(
                          width: 120,
                          height: 35,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(CupertinoIcons.calendar),
                              const SizedBox(width: 10),
                              Text(
                                "${DateFormat.EEEE("fr").format(_selectedDate).substring(0, 3)}. ${DateFormat.d("fr").format(_selectedDate)} ${DateFormat.MMMM("fr").format(_selectedDate).substring(0, 3)}.",
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Column(children: [
                              Text(
                                lang.lang == "English" ? "Begin" : "Début",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              const SizedBox(height: 15),
                              ElevatedButton(
                                onPressed: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((time) {
                                    if (time != null) {
                                      setState(() {
                                        _selectedTimeBegin = time;
                                      });
                                    }
                                  });
                                },
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all<Size>(
                                    const Size(90, 35),
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                ),
                                child: Text(
                                    '${_selectedTimeBegin.hour}:${_selectedTimeBegin.minute}'),
                              ),
                            ]),
                          ),
                          const SizedBox(width: 15),
                          const Icon(CupertinoIcons.arrow_right,
                              color: Colors.grey),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  lang.lang == "English" ? "End" : "Fin",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                const SizedBox(height: 15),
                                ElevatedButton(
                                  onPressed: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((time) {
                                      if (time != null) {
                                        setState(() {
                                          _selectedTimeEnd = time;
                                        });
                                      }
                                    });
                                  },
                                  style: ButtonStyle(
                                    minimumSize:
                                        MaterialStateProperty.all<Size>(
                                      const Size(90, 35),
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    '${_selectedTimeEnd.hour}:${_selectedTimeEnd.minute}',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      TextField(
                        controller: _notesController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(CupertinoIcons.doc_plaintext),
                          hintText: 'Notes',
                        ),
                        maxLines: null,
                        textAlignVertical: TextAlignVertical.top,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            left: 0,
            right: 0,
            child: SizedBox(
              height: screenHeight * 0.06,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => {Navigator.pop(context)},
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.transparent),
                          elevation: MaterialStateProperty.resolveWith<double>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed))
                                return 1.0;
                              return 0.0;
                            },
                          ),
                        ),
                        child: const Text(
                          "Annuler",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => {
                          _submitForm()
                          // addEvent(
                          //     _titleCotroller.toString(),
                          //     _selectedDate,
                          //     _selectedTimeBegin,
                          //     _selectedTimeEnd,
                          //     _notesController.toString()),
                        },
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.transparent),
                          elevation: MaterialStateProperty.resolveWith<double>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed))
                                return 1.0;
                              return 0.0;
                            },
                          ),
                        ),
                        child: const Text(
                          "Sauvegarder",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
