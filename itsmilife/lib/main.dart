import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itsmilife/pages/common/VerifCodePage.dart';
import 'package:itsmilife/pages/common/avatarProvider.dart';
import 'package:itsmilife/pages/common/settings/RoleProvider.dart';
import 'package:itsmilife/pages/common/splashScreen.dart';
import 'package:itsmilife/pages/normal_user/Home/bloc/home_bloc.dart';
import 'package:itsmilife/pages/normal_user/activit%C3%A9s/quizz/logic/quizz_page.dart';
import 'package:itsmilife/pages/normal_user/activit%C3%A9s/quizz/theme_details.dart';
import 'package:itsmilife/pages/normal_user/homepage/homepage.dart';
import 'package:itsmilife/pages/professional/activity/calendar/eventProvider.dart';
import 'package:itsmilife/pages/register.dart';
import 'package:itsmilife/widgets/bottomNavBar.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:itsmilife/pages/common/settings/darkModeProvider.dart';
import 'package:itsmilife/pages/common/settings/languageProvider.dart';
import 'package:itsmilife/pages/common/settings/notificationProvider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'pages/normal_user/activités/quizz/quizzBox.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  // Configuration de l'initialisation des notifications
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LocalStorage storage = new LocalStorage("storage");
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RoleProvider>(create: (context) => RoleProvider()),
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
        ChangeNotifierProvider<DarkModeProvider>(create: (context) => DarkModeProvider()),
        ChangeNotifierProvider<LanguageProvider>(create: (context) => LanguageProvider()),
        ChangeNotifierProvider<NotificationProvider>(create: (context) => NotificationProvider()),
        ChangeNotifierProvider(create: (context) => EventProvider()),
        ChangeNotifierProvider<AvatarProvider>(create: (context) => AvatarProvider()),
      ],
      child: MaterialApp(
        localizationsDelegates: const [GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate, SfGlobalLocalizations.delegate],
        supportedLocales: const [
          Locale('fr'),
          Locale('en'),
        ],
        locale: Locale('fr'),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: {
          ThemeDetailsPage.routeName: (context) => ThemeDetailsPage(),
          QuizPage.routeName: (context) => QuizPage(),
        },
      ),
    );
  }
}
