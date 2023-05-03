import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:itsmilife/pages/common/settings/languageProvider.dart';
import 'package:itsmilife/pages/professional/activity/calendar/eventProvider.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import 'Utils.dart';
import 'eventModelTest.dart';
import 'package:itsmilife/pages/professional/activity/calendar/addEventToServ.dart';
import 'package:itsmilife/pages/common/settings/darkModeProvider.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  _AddEvent createState() => _AddEvent();
}

class _AddEvent extends State<AddEvent> {
  final _formKey = GlobalKey<FormState>();
  final _titleCotroller = TextEditingController();
  final _notesController = TextEditingController();
  late DateTime _selectedTimeBegin;
  late DateTime _selectedTimeEnd;
  final DateTime _initialEnd = DateTime.now().add(const Duration(hours: 2));
  DateTime _selectedDate = DateTime.now();
  String _formattedSelectedDate = '';

  String _formatDatefr(DateTime date) {
    return "${DateFormat.EEEE("fr").format(date).substring(0, 3)}. ${DateFormat.d("fr").format(date)} ${DateFormat.MMMM("fr").format(date).substring(0, 3)}.";
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr_FR', null);
    _selectedTimeBegin = DateTime.now();
    _selectedTimeEnd = DateTime.now().add(const Duration(hours: 2));
    _notesController.text = "";
  }

  @override
  void dispose() {
    _titleCotroller.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<DarkModeProvider>(context);

    final screenHeight = MediaQuery.of(context).size.height;
    final appBar = AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
    final lang = Provider.of<LanguageProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: darkMode.darkMode ? const Color.fromARGB(255, 58, 50, 83) : Colors.grey[200],
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 3,
            right: 3,
            bottom: MediaQuery.of(context).viewInsets.bottom + 60,
            child: Form(
              key: _formKey,
              child: Container(
                decoration: BoxDecoration(
                  color: darkMode.darkMode ? Color.fromARGB(255, 45, 45, 45) : Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                        Text(
                          lang.lang == "English" ? "Add an Evend" : "Ajouter un évènement",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: darkMode.darkMode ? Colors.white : Color.fromARGB(255, 45, 45, 45),
                          ),
                        ),
                        const SizedBox(height: 60),
                        TextFormField(
                          controller: _titleCotroller,
                          decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.deepPurpleAccent, // Change the focused border color here
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                              prefixIcon: Icon(
                                CupertinoIcons.pencil,
                                color: darkMode.darkMode ? Colors.white : Color.fromARGB(255, 45, 45, 45),
                              ),
                              hintText: lang.lang == "English" ? "Title" : "Titre",
                              hintStyle: TextStyle(color: darkMode.darkMode ? Colors.white : Color.fromARGB(255, 45, 45, 45))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return lang.lang == "English" ? 'Please enter a title' : 'Veuillez entrer un titre';
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
                              firstDate: DateTime.now().subtract(const Duration(days: 365)),
                              lastDate: DateTime.now().add(const Duration(days: 365)),
                            ).then((date) {
                              if (date != null) {
                                setState(() {
                                  _selectedDate = date;
                                });
                              }
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) return Color.fromARGB(255, 45, 45, 45); // Color when button is pressed
                                return Colors.deepPurpleAccent; // Default color
                              },
                            ),
                            // minimumSize: MaterialStateProperty.all<Size>(
                            //   const Size(150, 35),
                            // ),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                                Text(_formatDatefr(_selectedDate)),
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
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: darkMode.darkMode ? Colors.white : Color.fromARGB(255, 45, 45, 45)),
                                ),
                                const SizedBox(height: 15),
                                ElevatedButton(
                                  onPressed: () {
                                    showTimePicker(context: context, initialTime: TimeOfDay.now()).then((time) {
                                      if (time != null) {
                                        setState(() {
                                          _selectedTimeBegin = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day, time.hour, time.minute);
                                        });
                                      }
                                    });
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states.contains(MaterialState.pressed)) return Color.fromARGB(255, 45, 45, 45); // Color when button is pressed
                                        return Colors.deepPurpleAccent; // Default color
                                      },
                                    ),
                                    minimumSize: MaterialStateProperty.all<Size>(
                                      const Size(90, 35),
                                    ),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                  child: Text(Utils.toTime(_selectedTimeBegin)),
                                ),
                              ]),
                            ),
                            const SizedBox(width: 15),
                            const Icon(CupertinoIcons.arrow_right, color: Colors.grey),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    lang.lang == "English" ? "End" : "Fin",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: darkMode.darkMode ? Colors.white : Color.fromARGB(255, 45, 45, 45)),
                                  ),
                                  const SizedBox(height: 15),
                                  ElevatedButton(
                                    onPressed: () {
                                      showTimePicker(context: context, initialTime: TimeOfDay(hour: _initialEnd.hour, minute: _initialEnd.minute)).then((time) {
                                        if (time != null) {
                                          setState(() {
                                            _selectedTimeEnd = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day, time.hour, time.minute);
                                          });
                                        }
                                      });
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          if (states.contains(MaterialState.pressed)) return Color.fromARGB(255, 45, 45, 45); // Color when button is pressed
                                          return Colors.deepPurpleAccent; // Default color
                                        },
                                      ),
                                      minimumSize: MaterialStateProperty.all<Size>(
                                        const Size(90, 35),
                                      ),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20.0),
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
                          decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.deepPurpleAccent, // Change the focused border color here
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                              prefixIcon: Icon(
                                CupertinoIcons.doc_plaintext,
                                color: darkMode.darkMode ? Colors.white : Color.fromARGB(255, 45, 45, 45),
                              ),
                              hintText: 'Notes',
                              hintStyle: TextStyle(color: darkMode.darkMode ? Colors.white : Color.fromARGB(255, 45, 45, 45))),
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
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                          elevation: MaterialStateProperty.resolveWith<double>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) {
                                return 1.0;
                              }
                              return 0.0;
                            },
                          ),
                        ),
                        child: Text(
                          "Annuler",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: darkMode.darkMode ? Colors.white : Color.fromARGB(255, 45, 45, 45)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          bool success = await addEvent(
                            title: _titleCotroller.text,
                            start: DateTime(_selectedTimeBegin.year, _selectedTimeBegin.month, _selectedTimeBegin.day, _selectedTimeBegin.hour, _selectedTimeBegin.minute),
                            end: DateTime(_selectedTimeEnd.year, _selectedTimeEnd.month, _selectedTimeEnd.day, _selectedTimeEnd.hour, _selectedTimeEnd.minute),
                            notes: _notesController.text,
                          );

                          Navigator.pop(context, success);
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                          elevation: MaterialStateProperty.resolveWith<double>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) {
                                return 1.0;
                              }
                              return 0.0;
                            },
                          ),
                        ),
                        child: Text(
                          "Sauvegarder",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: darkMode.darkMode ? Colors.white : Color.fromARGB(255, 45, 45, 45)),
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
