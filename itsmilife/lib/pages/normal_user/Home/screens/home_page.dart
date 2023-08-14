import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itsmilife/pages/normal_user/Home/widgets/date.dart';
import 'package:itsmilife/pages/normal_user/Home/widgets/emoticon_card.dart';
import 'package:itsmilife/pages/normal_user/Home/widgets/exercise_tile.dart';
import 'package:itsmilife/pages/normal_user/Home/widgets/greet.dart';
import 'package:itsmilife/pages/normal_user/chat/chatProUser.dart';
import 'package:itsmilife/pages/normal_user/chat/chatbot.dart';
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

class HomeBody extends StatelessWidget {
  const HomeBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 98, 128, 182),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Greet(),
                  const Date(),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Comment vous sentez vous ?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      EmoticonCard(
                        emoticonFace: '😔',
                        mood: 'Mal',
                      ),
                      EmoticonCard(
                        emoticonFace: '😊',
                        mood: 'Bien',
                      ),
                      EmoticonCard(
                        emoticonFace: '😁',
                        mood: 'Très bien',
                      ),
                      EmoticonCard(
                        emoticonFace: '😃',
                        mood: 'Excellent',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 98, 128, 182),
                      blurRadius: 10,
                    ),
                  ],
                  color: Color.fromARGB(255, 224, 224, 224),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(
                      35.0,
                    ),
                    topRight: Radius.circular(
                      35.0,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          ChatBot(),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        return SlideTransition(
                                          position: Tween<Offset>(
                                            begin: const Offset(1, 0),
                                            end: Offset.zero,
                                          ).animate(animation),
                                          child: child,
                                        );
                                      },
                                      transitionDuration:
                                          const Duration(milliseconds: 300),
                                    ),
                                  );
                                },
                                child: ExerciseTile(
                                  exercise: 'Discuter avec Smile',
                                  subExercise: 'Apprenez en plus sur vous',
                                  icon: CupertinoIcons.smiley_fill,
                                  color: Colors.orange,
                                )),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        ChatProUser(),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      return SlideTransition(
                                        position: Tween<Offset>(
                                          begin: const Offset(1, 0),
                                          end: Offset.zero,
                                        ).animate(animation),
                                        child: child,
                                      );
                                    },
                                    transitionDuration:
                                        const Duration(milliseconds: 300),
                                  ),
                                );
                              },
                              child: ExerciseTile(
                                exercise: 'Discuter avec un Pro',
                                subExercise: 'Franchissez le pas',
                                icon: CupertinoIcons.person_alt,
                                color: Colors.pink,
                              ),
                            ),
                            InkWell(
                                onTap: () {
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
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                8))),
                                              ),
                                              const SizedBox(height: 80),
                                              GestureDetector(
                                                // ignore: avoid_print
                                                onTap: _callSos,
                                                child: Image.asset(
                                                    "assets/sos.png"),
                                              ),
                                              const SizedBox(height: 20),
                                              const Text(
                                                "SOS suicide",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              const SizedBox(height: 80),
                                              GestureDetector(
                                                // ignore: avoid_print
                                                onTap: _callEmergency,
                                                child: Image.asset(
                                                    "assets/sos.png"),
                                              ),
                                              const SizedBox(height: 20),
                                              Text(
                                                "Urgences",
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
                                child: ExerciseTile(
                                  exercise: 'Urgences',
                                  subExercise: 'Contacter les urgences',
                                  icon: CupertinoIcons.phone_solid,
                                  color: Color.fromARGB(255, 255, 0, 0),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
