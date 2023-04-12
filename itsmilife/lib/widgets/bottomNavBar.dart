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

class Home extends StatefulWidget{
  const Home({Key? key}) : super(key: key);

  @override
    State <Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 1;

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
        // appBar: AppBar(
        //   title:const Text("Itsmilife"),
        // ),
        body: (user.Setrolestate) ? screenspro[index] : screens[index],
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          items: items,
          index: index,
          height: 60,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          onTap: (index) => setState(() => this.index = index),
        ),
    );
  }
}