import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:itsmilife/pages/common/chat/chatDetailPage.dart';
import 'package:itsmilife/pages/common/chat/chatPage.dart';
import 'package:itsmilife/pages/common/settings/settings.dart';
import 'package:itsmilife/pages/login.dart';
import 'package:itsmilife/pages/normal_user/homepage/homepage.dart';
import 'package:provider/provider.dart';
import 'package:itsmilife/pages/common/settings/darkModeProvider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return ChangeNotifierProvider<DarkModeProvider>(
      create: (context) => DarkModeProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
