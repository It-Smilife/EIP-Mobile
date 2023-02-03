import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:itsmilife/pages/normal_user/homepage/homepage.dart';
import 'package:itsmilife/pages/normal_user/onboarding/onboarding.dart';
import 'package:itsmilife/pages/register.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late String _version = "0.0.0";

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  void _loadVersion() async {
    String jsonString = await rootBundle.loadString('assets/version.json');
    Map<String, dynamic> json = jsonDecode(jsonString);
    setState(() {
      _version = json['version'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedSplashScreen(
          splash: 'assets/logo.png',
          splashIconSize: double.infinity,
          nextScreen: const RegisterPage(),
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.bottomToTop,
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: const EdgeInsets.all(5),
                child: Text('version $_version',
                    style: const TextStyle(fontSize: 10, color: Colors.grey))))
      ],
    );
  }
}
