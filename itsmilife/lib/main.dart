import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:itsmilife/pages/common/settings/RoleProvider.dart';
import 'package:itsmilife/pages/common/splashScreen.dart';
import 'package:itsmilife/pages/normal_user/activit%C3%A9s/quizz/logic/quizz_page.dart';
import 'package:itsmilife/pages/normal_user/activit%C3%A9s/quizz/theme_details.dart';
import 'package:itsmilife/pages/normal_user/homepage/homepage.dart';
import 'package:itsmilife/pages/register.dart';
import 'package:itsmilife/widgets/bottomNavBar.dart';
import 'package:provider/provider.dart';
import 'package:itsmilife/pages/common/settings/darkModeProvider.dart';
import 'package:itsmilife/pages/common/settings/languageProvider.dart';

import 'pages/normal_user/activités/quizz/quizzBox.dart';

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
        ChangeNotifierProvider<RoleProvider>(
            create: (context) => RoleProvider()),
        ChangeNotifierProvider<DarkModeProvider>(
            create: (context) => DarkModeProvider()),
        ChangeNotifierProvider<LanguageProvider>(
            create: (context) => LanguageProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: {
          ThemeDetailsPage.routeName: (context) =>
       ThemeDetailsPage(),
       QuizPage.routeName: (context) =>
       QuizPage(),
  },
      ),
    );
  }
}
