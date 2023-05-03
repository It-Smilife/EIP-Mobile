import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Utils.dart';
import 'eventModelTest.dart';
import 'eventProvider.dart';
import 'package:provider/provider.dart';
import 'package:itsmilife/pages/common/settings/languageProvider.dart';
import 'updateEvent.dart';
import 'package:itsmilife/pages/common/settings/darkModeProvider.dart';

class EditEventPage extends StatefulWidget {
  final MyEvent? event;

  const EditEventPage({super.key, required this.event});

  @override
  State<EditEventPage> createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _notesController = TextEditingController();
  late DateTime _start;
  late DateTime _end;
  String _formattedSelectedDate = '';

  String _formatDate(DateTime date) {
    return "${DateFormat.EEEE("fr").format(date).substring(0, 3)}. ${DateFormat.d("fr").format(date)} ${DateFormat.MMMM("fr").format(date).substring(0, 3)}.";
  }

  @override
  void initState() {
    super.initState();

    if (widget.event == null) {
      _start = DateTime.now();
      _end = DateTime.now().add(const Duration(hours: 2));
      _formattedSelectedDate = _formatDate(_start);
    } else {
      final event = widget.event!;
      _titleController.text = event.title;
      _notesController.text = event.notes;
      _start = event.start;
      _formattedSelectedDate = _formatDate(_start);
      _end = event.end;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _notesController.dispose();

    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final event = MyEvent(
        id: "",
        title: _titleController.text,
        notes: _notesController.text,
        start: _start,
        end: _end,
      );

      final isEditing = widget.event != null;
      final provider = Provider.of<EventProvider>(context, listen: false);

      if (isEditing) {
        provider.editEvent(event, widget.event!);
        Navigator.pop(context);
      } else {
        provider.addEvent(event);
      }
    }
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
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                        Text(
                          lang.lang == "English" ? "Edit this event" : "Modifier cet évènement",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: darkMode.darkMode ? Colors.white : Color.fromARGB(255, 45, 45, 45),
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: _titleController,
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
                            hintText: _titleController.text,
                            hintStyle: TextStyle(
                              color: darkMode.darkMode ? Colors.white : Color.fromARGB(255, 45, 45, 45),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return lang.lang == "English" ? 'Please enter a title' : 'Veuillez entrer un titre';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 50),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     showDatePicker(
                        //       context: context,
                        //       initialDate: _start,
                        //       firstDate: DateTime.now()
                        //           .subtract(const Duration(days: 365)),
                        //       lastDate:
                        //           DateTime.now().add(const Duration(days: 365)),
                        //     ).then((date) {
                        //       if (date != null) {
                        //         setState(() {
                        //           _start = date;
                        //         });
                        //       }
                        //     });
                        //   },
                        //   style: ButtonStyle(
                        //     // minimumSize: MaterialStateProperty.all<Size>(
                        //     //   const Size(150, 35),
                        //     // ),
                        //     shape: MaterialStateProperty.all<
                        //         RoundedRectangleBorder>(
                        //       RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(20.0),
                        //       ),
                        //     ),
                        //   ),
                        //   child: SizedBox(
                        //     width: 120,
                        //     height: 35,
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         const Icon(CupertinoIcons.calendar),
                        //         const SizedBox(width: 10),
                        //         Text(_formatDate(_start)),
                        //       ],
                        //     ),
                        //   ),
                        // ),
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
                                          _start = DateTime(_start.year, _start.month, _start.day, time.hour, time.minute);
                                        });
                                        print(_start.day);
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
                                  child: Text(Utils.toTime(_start)),
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
                                      showTimePicker(context: context, initialTime: TimeOfDay.now()).then((time) {
                                        if (time != null) {
                                          setState(() {
                                            _end = DateTime(_end.year, _end.month, _end.day, time.hour, time.minute);
                                          });
                                          print(_end.day);
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
                                    child: Text(Utils.toTime(_end)),
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
                          // _submitForm(),
                          if (_formKey.currentState!.validate()) {
                            await updateEvent(
                              widget.event!.id,
                              _titleController.text,
                              _start,
                              _end,
                              _notesController.text,
                            );
                            Navigator.pop(context, true);
                          }
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
