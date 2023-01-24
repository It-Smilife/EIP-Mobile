import 'package:flutter/material.dart';
import 'package:itsmilife/pages/normal_user/homepage/carouselle.dart';
import 'package:itsmilife/pages/normal_user/activit%C3%A9s/activit%C3%A9s.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/settings/settings.dart';
import 'package:itsmilife/pages/common/settings/darkModeProvider.dart';
import 'package:itsmilife/pages/common/settings/languageProvider.dart';

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
            pageBuilder: (context, animation, secondaryAnimation) => const HomePage(),
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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: darkMode.darkMode ? const Color.fromARGB(255, 58, 50, 83) : const Color.fromARGB(255, 234, 234, 234),
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
            padding: const EdgeInsets.only(bottom: 5),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0.1),
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              onPressed: () {
                print("ok");
              },
              //lang.lang == "English" ? "Dark mode" : "Mode sombre"
              child: Text( lang.lang == "English" ? "Emergency" : "Uregence",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        )
      ]),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey, width: 0.25))),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.directions_run),
              label: lang.lang == 'English' ? 'activities' : 'activités',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: lang.lang == 'English' ? 'home' : 'accueil',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: lang.lang == 'English' ? 'settings' : 'paramètres',
            ),
          ],
          backgroundColor: const Color.fromARGB(255, 98, 128, 182),
          currentIndex: _selectedIndex,
          selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
