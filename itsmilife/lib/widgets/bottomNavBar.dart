import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:itsmilife/pages/normal_user/activités/activités.dart';
import 'package:itsmilife/pages/normal_user/homepage/homepage.dart';
import 'package:itsmilife/pages/common/settings/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:itsmilife/pages/professional/HomePro.dart';
import 'package:itsmilife/pages/professional/activity/categorypro.dart';
import 'package:provider/provider.dart';

import '../pages/common/settings/RoleProvider.dart';

class Home extends StatefulWidget {
  late int h_index;

  Home({Key? key, this.h_index = 1}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final screens = [
    const ActivityPage(),
    const HomePage(),
    const SettingsPage()
  ];

  final screenspro = [
    const CategoryPro(),
    const HomePro(),
    const SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<RoleProvider>(context);
    final items = <Widget>[
      const Icon(CupertinoIcons.doc_plaintext, size: 30),
      const Icon(CupertinoIcons.home, size: 30),
      const Icon(CupertinoIcons.gear_alt, size: 30),
    ];
    return Scaffold(
      extendBody: true,
      body: (user.Setrolestate) ? screenspro[widget.h_index] : screens[widget.h_index],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
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
