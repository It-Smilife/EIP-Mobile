import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itsmilife/pages/common/settings/languageProvider.dart';
import 'package:itsmilife/pages/normal_user/Home/widgets/date.dart';
import 'package:itsmilife/pages/normal_user/Home/widgets/emoticon_card.dart';
import 'package:itsmilife/pages/normal_user/Home/widgets/exercise_tile.dart';
import 'package:itsmilife/pages/normal_user/Home/widgets/greet.dart';
import 'package:itsmilife/pages/normal_user/chat/chatProUser.dart';
import 'package:itsmilife/pages/normal_user/chat/chatbot.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:itsmilife/pages/common/settings/darkModeProvider.dart';
import 'package:provider/provider.dart';

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
    final darkMode = Provider.of<DarkModeProvider>(context);
    final lang = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: darkMode.darkMode ? const Color.fromARGB(255, 58, 50, 83) : const Color.fromARGB(255, 98, 128, 182),
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
                    children: [
                      Text(
                        lang.lang == "English" ? "How are you today ?" : 'Comment vous sentez vous ?',
                        style: const TextStyle(
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
                    children: [
                      EmoticonCard(
                        emoticonFace: '😔',
                        mood: lang.lang == "English" ? "Bad" : 'Mal',
                      ),
                      EmoticonCard(
                        emoticonFace: '😊',
                        mood: lang.lang == "English" ? "Good" : 'Bien',
                      ),
                      EmoticonCard(
                        emoticonFace: '😁',
                        mood: lang.lang == "English" ? "Very Good" : 'Très bien',
                      ),
                      const EmoticonCard(
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
                  boxShadow: [
                    BoxShadow(
                      color: darkMode.darkMode ? const Color.fromARGB(255, 79, 79, 79) : const Color.fromARGB(255, 98, 128, 182),
                      blurRadius: 10,
                    ),
                  ],
                  color: darkMode.darkMode ? const Color.fromARGB(255, 79, 79, 79) : const Color.fromARGB(255, 224, 224, 224),
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
                                      pageBuilder: (context, animation, secondaryAnimation) => ChatBot(),
                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
                                },
                                child: ExerciseTile(
                                  exercise: lang.lang == "English" ? "Talk with smile" : 'Discuter avec Smile',
                                  subExercise: '',
                                  icon: CupertinoIcons.smiley_fill,
                                  color: Colors.orange,
                                )),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) => const ChatProUser(),
                                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
                              },
                              child: ExerciseTile(
                                exercise: lang.lang == "English" ? "Talk with a professional" : 'Discuter avec un Pro',
                                subExercise: '',
                                icon: CupertinoIcons.person_alt,
                                color: Colors.pink,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: darkMode.darkMode ? const Color.fromARGB(255, 79, 79, 79) : Colors.white,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                    ),
                                  ),
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return SizedBox(
                                      height: 250,
                                      child: Center(
                                        child: Column(
                                          children: <Widget>[
                                            const SizedBox(height: 20),
                                            Container(
                                              height: 10,
                                              width: 100,
                                              decoration: const BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(8))),
                                            ),
                                            const SizedBox(height: 60),
                                            Row(
                                              // Utilisez Row au lieu de Column ici
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Alignez les enfants au centre
                                              children: <Widget>[
                                                GestureDetector(
                                                    // ignore: avoid_print
                                                    onTap: _callSos,
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(5), // Set the desired border radius
                                                      child: Image.asset(
                                                        "assets/sos.png",
                                                        width: 80,
                                                        height: 80,
                                                      ),
                                                    )),
                                                const SizedBox(width: 20), // Ajoutez un espacement entre les icônes
                                                GestureDetector(
                                                    // ignore: avoid_print
                                                    onTap: _callEmergency,
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(5), // Set the desired border radius
                                                      child: Image.asset(
                                                        "assets/urgence.png",
                                                        width: 80,
                                                        height: 80,
                                                      ),
                                                    )),
                                              ],
                                            ),
                                            const SizedBox(height: 20),
                                            Row(
                                              // Ajoutez une autre rangée pour les textes
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Alignez les enfants au centre
                                              children: <Widget>[
                                                Text(
                                                  "SOS suicide",
                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: darkMode.darkMode ? Colors.white : Colors.black),
                                                ),
                                                const SizedBox(width: 20), // Ajoutez un espacement entre les textes
                                                Text(
                                                  lang.lang == "English" ? "Emergency" : "Urgences",
                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: darkMode.darkMode ? Colors.white : Colors.black),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: ExerciseTile(
                                exercise: lang.lang == "English" ? "Emergency" : 'Urgences',
                                subExercise: '',
                                icon: CupertinoIcons.phone_solid,
                                color: const Color.fromARGB(255, 255, 0, 0),
                              ),
                            ),
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
