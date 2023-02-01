import 'package:flutter/material.dart';
import 'package:itsmilife/pages/normal_user/homepage/carouselle.dart';
import 'package:itsmilife/pages/normal_user/activit%C3%A9s/activit%C3%A9s.dart';
import 'package:itsmilife/pages/normal_user/onboarding/onboarding.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/settings/settings.dart';
import 'package:itsmilife/pages/common/settings/darkModeProvider.dart';
import 'package:hive/hive.dart';
import 'package:itsmilife/pages/common/settings/languageProvider.dart';
import 'package:url_launcher/url_launcher.dart';

_callSos() async {
  var url = Uri.parse("tel:3114");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

_callEmergency() async {
  var url = Uri.parse("tel:17");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

class HomePage extends StatefulWidget {
  final int initialSelectedIndex;

  const HomePage({Key? key, this.initialSelectedIndex = 1}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _loadSelectedIndex();
  }

  void _loadSelectedIndex() async {
    final prefs = await SharedPreferences.getInstance();
    _selectedIndex = prefs.getInt('selectedIndex') ?? 1;
  }

  void _saveSelectedIndex() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedIndex', _selectedIndex);
  }

  void setSelectedIndex(int value) {
    setState(() {
      _selectedIndex = value;
      _saveSelectedIndex();
    });
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: activités',
      style: optionStyle,
    ),
    HomeCard(),
    Text(
      'Index 2: settings',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const ActivityPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
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
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const HomePage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
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
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const SettingsPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
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
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<DarkModeProvider>(context);
    final lang = Provider.of<LanguageProvider>(context);
    return Scaffold(
      //backgroundColor: darkMode.darkMode ? const Color.fromARGB(255, 58, 50, 83) : const Color.fromARGB(255, 234, 234, 234),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: darkMode.darkMode
            ? const Color.fromARGB(255, 58, 50, 83)
            : Color.fromARGB(255, 255, 255, 255),
        title: const Text("It'Smilife",
            style: TextStyle(
                color: Color.fromARGB(255, 98, 128, 182),
                fontSize: 25,
                fontWeight: FontWeight.bold)),
      ),
      body: Stack(children: <Widget>[
        const HomeCard(),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.12),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 0.1),
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              child: Text(
                lang.lang == "English" ? "Emergency" : "Urgence",
                style: const TextStyle(color: Colors.white),
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  isScrollControlled: true,
                  builder: (context) {
                    return SizedBox(
                      height: 450,
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            const SizedBox(height: 20),
                            Container(
                              height: 10,
                              width: 100,
                              decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                            ),
                            const SizedBox(height: 80),
                            GestureDetector(
                              // ignore: avoid_print
                              onTap: _callSos,
                              child: Image.asset("assets/sos.png"),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "SOS suicide",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            const SizedBox(height: 80),
                            GestureDetector(
                              // ignore: avoid_print
                              onTap: _callEmergency,
                              child: Image.asset("assets/sos.png"),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              lang.lang == "English" ? "Emergency" : "Urgences",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        )
      ]),
      // bottomNavigationBar: Container(
      //   decoration: BoxDecoration(
      //       border:
      //           Border(top: BorderSide(color: Colors.grey, width: 0.25))),
      //   child: BottomNavigationBar(
      //     items: const <BottomNavigationBarItem>[
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.directions_run),
      //         label: 'activités',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.home),
      //         label: 'home',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.settings),
      //         label: 'settings',
      //       ),
      //     ],
      //     backgroundColor: Color.fromARGB(255, 98, 128, 182),
      //     currentIndex: _selectedIndex,
      //     selectedItemColor: Color.fromARGB(255, 255, 255, 255),
      //     onTap: _onItemTapped,
      //   ),
      // ),
    );
  }
}
