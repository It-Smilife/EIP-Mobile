import 'package:flutter/material.dart';
import 'package:itsmilife/pages/common/settings/darkModeProvider.dart';
import 'package:itsmilife/pages/professional/chatPro/patient_list.dart';
import 'package:provider/provider.dart';

import '../common/settings/languageProvider.dart';

class HomePro extends StatefulWidget {
  const HomePro({super.key});

  @override
  _HomeProState createState() => _HomeProState();
}

class _HomeProState extends State<HomePro> {
  String _title = "Contacts";

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final darkMode = Provider.of<DarkModeProvider>(context);
    return Scaffold(
      backgroundColor: darkMode.darkMode
          ? const Color.fromARGB(255, 58, 50, 83)
          : const Color.fromARGB(255, 234, 234, 234),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text("It'Smilife",
            style: TextStyle(
                color: Color.fromARGB(255, 98, 128, 182),
                fontSize: 25,
                fontWeight: FontWeight.bold)),
      ),
      body: Scaffold(
        backgroundColor: darkMode.darkMode
            ? const Color.fromARGB(255, 58, 50, 83)
            : const Color.fromARGB(255, 234, 234, 234),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.04),
                  child: Container(
                    width: MediaQuery.of(context).size.height * 0.45,
                    height: MediaQuery.of(context).size.height * 0.07,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 98, 128, 182),
                          offset: Offset(0.0, 0.0),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        _title,
                        style:
                            const TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.08),
                    //The gesture detector widget will detect swipes and taps of the image card
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(255, 98, 128, 182),
                                offset: Offset(0, 5),
                                blurRadius: 5,
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          height: MediaQuery.of(context).size.width * 1,
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    // handle the tap event on the image
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            ListPatient(),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          return SlideTransition(
                                            position: Tween<Offset>(
                                              begin: const Offset(1, 0),
                                              end: Offset.zero,
                                            ).animate(animation),
                                            child: child,
                                          );
                                        },
                                        transitionDuration:
                                            const Duration(milliseconds: 300),
                                      ),
                                    );
                                  },
                                  child: Image.asset(
                                    'assets/contact.png',
                                    height: MediaQuery.of(context).size.width * 0.6,
                                    width: MediaQuery.of(context).size.width * 0.6,
                                  ),
                                ),
                              ]),
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
