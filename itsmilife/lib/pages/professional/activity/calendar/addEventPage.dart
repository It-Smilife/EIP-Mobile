import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:itsmilife/pages/common/settings/languageProvider.dart';
import 'package:itsmilife/pages/professional/activity/calendar/eventProvider.dart';
import 'package:provider/provider.dart';
import 'package:itsmilife/pages/professional/activity/calendar/eventModel.dart';
import 'package:collection/collection.dart';
import 'calendar.dart';
import 'Utils.dart';
import 'eventModelTest.dart';

class TestEvent extends StatefulWidget {
  const TestEvent({super.key});

  @override
  _AddEvent createState() => _AddEvent();
}

class _AddEvent extends State<TestEvent> {
  final _formKey = GlobalKey<FormState>();
  final _titleCotroller = TextEditingController();
  final _notesController = TextEditingController();
  late DateTime _selectedTimeBegin;
  late DateTime _selectedTimeEnd;
  DateTime _selectedDate = DateTime.now();
  String _formattedSelectedDate = '';
  Map<DateTime, List<Event>> events = {};

  String _formatDate(DateTime date) {
    return "${DateFormat.EEEE("fr").format(date).substring(0, 3)}. ${DateFormat.d("fr").format(date)} ${DateFormat.MMMM("fr").format(date).substring(0, 3)}.";
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr_FR', null);
    _selectedTimeBegin = DateTime.now();
    _selectedTimeEnd = DateTime.now().add(Duration(hours: 2));
    _formattedSelectedDate = _formatDate(_selectedDate);
  }

  @override
  void dispose() {
    _titleCotroller.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_titleCotroller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Le champ Titre ne doit pas être vide.'),
        ),
      );
    } else {
      final event = MyEvent(
        title: _titleCotroller.text,
        notes: _notesController.text,
        start: DateTime(
            _selectedDate.year,
            _selectedDate.month,
            _selectedDate.day,
            _selectedTimeBegin.hour,
            _selectedTimeBegin.minute),
        end: DateTime(_selectedDate.year, _selectedDate.month,
            _selectedDate.day, _selectedTimeEnd.hour, _selectedTimeEnd.minute),
      );
      final provider = Provider.of<EventProvider>(context, listen: false);
      provider.addEvent(event);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final appBar = AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
    final lang = Provider.of<LanguageProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 205, 205, 205),
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
            child: Form(
              key: _formKey,
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
                        TextFormField(
                          controller: _titleCotroller,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(CupertinoIcons.pencil),
                            hintText:
                                lang.lang == "English" ? "Title" : "Titre",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return lang.lang == "English"
                                  ? 'Please enter a title'
                                  : 'Veuillez entrer un titre';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 50),
                        ElevatedButton(
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: _selectedDate,
                              firstDate:
                                  DateTime.now().subtract(Duration(days: 365)),
                              lastDate: DateTime.now().add(Duration(days: 365)),
                            ).then((date) {
                              if (date != null) {
                                setState(() {
                                  _selectedDate = date;
                                });
                                print(_selectedDate);
                              }
                            });
                          },
                          style: ButtonStyle(
                            // minimumSize: MaterialStateProperty.all<Size>(
                            //   const Size(150, 35),
                            // ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
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
                                Text(_formattedSelectedDate),
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                const SizedBox(height: 15),
                                ElevatedButton(
                                  onPressed: () {
                                    showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now())
                                        .then((time) {
                                      if (time != null) {
                                        setState(() {
                                          _selectedTimeBegin = DateTime(
                                              _selectedDate.year,
                                              _selectedDate.month,
                                              _selectedDate.day,
                                              time.hour,
                                              time.minute);
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
                                  child: Text(Utils.toTime(_selectedTimeBegin)),
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
                                              initialTime: TimeOfDay.now())
                                          .then((time) {
                                        if (time != null) {
                                          setState(() {
                                            _selectedTimeEnd = DateTime(
                                                _selectedDate.year,
                                                _selectedDate.month,
                                                _selectedDate.day,
                                                time.hour,
                                                time.minute);
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
                                    child: Text(Utils.toTime(_selectedTimeEnd)),
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
                          if (_formKey.currentState!.validate())
                            {
                              _submitForm(),
                            }
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
