import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itsmilife/pages/normal_user/activit%C3%A9s/forum/forum.dart';
import 'package:itsmilife/pages/normal_user/activit%C3%A9s/quizz/category.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/settings/settings.dart';
import '../homepage/carouselle.dart';
import '../homepage/homepage.dart';
import 'package:itsmilife/pages/common/settings/darkModeProvider.dart';
import 'package:provider/provider.dart';

import 'quizz/theme.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  int _selectedIndex = 0;

  late List<Category> _themes;

  @override
  void initState() {
    super.initState();
    getThemes().then((value) {
      setState(() {
        _themes = value;
      });
    });
  }

  AnotherFile() {
    _loadSelectedIndex();
  }

  void _loadSelectedIndex() async {
    final prefs = await SharedPreferences.getInstance();
    _selectedIndex = prefs.getInt('selectedIndex') ?? 1;
  }

  int get selectedIndex => _selectedIndex;

  void someMethod() {
    // Use the selectedIndex variable here
    print(selectedIndex);
  }

  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<DarkModeProvider>(context);
    var themes = null;
    getThemes().then((value) {
      themes = value;
    });
    return Scaffold(
      backgroundColor: darkMode.darkMode ? const Color.fromARGB(255, 58, 50, 83) : Color.fromARGB(255, 224, 224, 224),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: darkMode.darkMode ? const Color.fromARGB(255, 32, 32, 32) : const Color.fromARGB(255, 255, 255, 255),
        title: Text("It'Smilife", style: TextStyle(color: darkMode.darkMode ? Colors.white :Color.fromARGB(255, 98, 128, 182), fontSize: 25, fontWeight: FontWeight.bold)),
        leading: Icon(CupertinoIcons.add, color: darkMode.darkMode ? const Color.fromARGB(255, 32, 32, 32) : const Color.fromARGB(255, 255, 255, 255),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Container(
                decoration: BoxDecoration(
                  color: darkMode.darkMode ? Color.fromARGB(255, 45, 45, 45) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: darkMode.darkMode ? Color.fromARGB(255, 58, 58, 58) : const Color.fromARGB(255, 98, 128, 182),
                      offset: const Offset(0, 5),
                      blurRadius: 5,
                      spreadRadius: 0,
                    )
                  ],
                ),
                height: MediaQuery.of(context).size.height * 0.35,
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).size.width * 0.1),
                    GestureDetector(
                      onTap: () {
                        // handle the tap event on the image
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => CategoryPage(themes: themes),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              return SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(1, 0),
                                  end: Offset.zero,
                                ).animate(animation),
                                child: child,
                              );
                            },
                            transitionDuration: const Duration(milliseconds: 300),
                          ),
                        );
                      },
                      child: Image.asset(
                        'assets/quizz.png',
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.height * 0.2,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.06),
                    GestureDetector(
                      onTap: () {
                        // handle the tap event on the title
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => CategoryPage(themes: themes),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              return SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(1, 0),
                                  end: Offset.zero,
                                ).animate(animation),
                                child: child,
                              );
                            },
                            transitionDuration: const Duration(milliseconds: 300),
                          ),
                        );
                      },
                      child: Container(
                        width: 270,
                        decoration: BoxDecoration(
                          color: darkMode.darkMode ? const Color.fromARGB(255, 108, 108, 108) : Color.fromARGB(255, 98, 128, 182),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 0,
                            ),
                            Text(
                              'Quizz',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Container(
                decoration: BoxDecoration(
                  color: darkMode.darkMode ? Color.fromARGB(255, 45, 45, 45) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: darkMode.darkMode ? Color.fromARGB(255, 58, 58, 58) : const Color.fromARGB(255, 98, 128, 182),
                      offset: const Offset(0, 5),
                      blurRadius: 5,
                      spreadRadius: 0,
                    )
                  ],
                ),
                height: MediaQuery.of(context).size.height * 0.35,
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).size.width * 0.1),
                    GestureDetector(
                      onTap: () {
                        // handle the tap event on the image
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => const Forum(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              return SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(1, 0),
                                  end: Offset.zero,
                                ).animate(animation),
                                child: child,
                              );
                            },
                            transitionDuration: const Duration(milliseconds: 300),
                          ),
                        );
                      },
                      child: Image.asset(
                        'assets/forum.png',
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.height * 0.2,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.06),
                    GestureDetector(
                      onTap: () {
                        // handle the tap event on the title
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => const Forum(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              return SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(1, 0),
                                  end: Offset.zero,
                                ).animate(animation),
                                child: child,
                              );
                            },
                            transitionDuration: const Duration(milliseconds: 300),
                          ),
                        );
                      },
                      child: Container(
                        width: 270,
                        decoration: BoxDecoration(
                          color: darkMode.darkMode ? const Color.fromARGB(255, 108, 108, 108) : Color.fromARGB(255, 98, 128, 182),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Column(
                          children: const [
                            SizedBox(
                              width: double.infinity,
                              height: 0,
                            ),
                            Text(
                              'Forum',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          ],
        ),
      ),
    );
  }
}
