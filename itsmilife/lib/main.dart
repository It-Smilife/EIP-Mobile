import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:itsmilife/pages/common/splashScreen.dart';
import 'package:itsmilife/pages/normal_user/homepage/homepage.dart';
import 'package:itsmilife/pages/register.dart';
import 'package:provider/provider.dart';
import 'package:itsmilife/pages/common/settings/darkModeProvider.dart';
import 'package:itsmilife/pages/common/settings/languageProvider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DarkModeProvider>(
            create: (context) => DarkModeProvider()),
        ChangeNotifierProvider<LanguageProvider>(
            create: (context) => LanguageProvider())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
