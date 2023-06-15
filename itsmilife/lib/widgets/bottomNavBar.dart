import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:itsmilife/pages/normal_user/activités/activités.dart';
import 'package:itsmilife/pages/normal_user/homepage/homepage.dart';
import 'package:itsmilife/pages/common/settings/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:itsmilife/pages/professional/HomePro.dart';
import 'package:itsmilife/pages/professional/activity/categorypro.dart';
import 'package:provider/provider.dart';
import 'package:itsmilife/pages/common/settings/darkModeProvider.dart';
import '../pages/common/settings/RoleProvider.dart';
import 'package:itsmilife/pages/normal_user/Home/screens/home_page.dart';

class Home extends StatefulWidget {
  late int h_index;

  Home({Key? key, this.h_index = 1}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final screens = [
    const ActivityPage(),
    const HomeBody(),
    const SettingsPage()
  ];

  final screenspro = [
    const CategoryPro(),
    const HomePro(),
    const SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<DarkModeProvider>(context);
    final user = Provider.of<RoleProvider>(context);
    final items = <Widget>[
      Icon(CupertinoIcons.doc_plaintext,
          size: 30, color: darkMode.darkMode ? Colors.white : Colors.black),
      Icon(CupertinoIcons.home,
          size: 30, color: darkMode.darkMode ? Colors.white : Colors.black),
      Icon(CupertinoIcons.gear_alt,
          size: 30, color: darkMode.darkMode ? Colors.white : Colors.black),
    ];
    return Scaffold(
      extendBody: true,
      body: (user.Setrolestate)
          ? screenspro[widget.h_index]
          : screens[widget.h_index],
      bottomNavigationBar: CurvedNavigationBar(
        color: darkMode.darkMode
            ? const Color.fromARGB(255, 108, 108, 108)
            : Colors.white,
        backgroundColor: (widget.h_index == 1) ? Color.fromARGB(255, 224, 224, 224) : Colors.transparent,
        items: items,
        index: widget.h_index,
        height: 60,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) => setState(() => widget.h_index = index),
      ),
    );
  }
}
