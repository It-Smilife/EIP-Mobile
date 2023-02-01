import 'package:flutter/material.dart';
import 'package:itsmilife/pages/normal_user/chat/chatpro.dart';
import 'package:itsmilife/pages/common/settings/darkModeProvider.dart';
import 'package:provider/provider.dart';
import 'package:itsmilife/pages/common/settings/languageProvider.dart';

import '../chat/chatbot.dart';
import 'cardData.dart';

class HomeCard extends StatefulWidget {
  const HomeCard({Key? key}) : super(key: key);

  @override
  _HomeCardState createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  String _title = "Discuter avec Smile";

  //calls the function to move to next image
  void buildNextImage() {
    setState(() {
      CardData().nextImage();
      _title = "Discuter avec un Professionnel";
    });
  }

  //calls the function to move to previous image
  void buildPreviousImage() {
    setState(() {
      CardData().previousImage();
      _title = "Discuter avec Smile";
    });
  }

  //calls the function to move to build dot indicator in this widget
  Widget rebuildDotIndicator() {
    return CardData().buildDotsIndicator();
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final darkMode = Provider.of<DarkModeProvider>(context);
    String lang1 =
        lang.lang == "English" ? "Talk with Smile" : "Discuter avec Smile";
    String lang2 = lang.lang == "English"
        ? "Talk with a preofessional"
        : "Discuter avec un professionnel";
    return Scaffold(
      backgroundColor: darkMode.darkMode
          ? const Color.fromARGB(255, 58, 50, 83)
          : const Color.fromARGB(255, 234, 234, 234),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
                child: Container(
                  width: MediaQuery.of(context).size.height * 0.40,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(255, 98, 128, 182),
                        offset: Offset(0.0, 0.0),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      CardData().buildDotsIndicator().position == 0
                          ? _title = lang1
                          : _title = lang2,
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(50),
                //The gesture detector widget will detect swipes and taps of the image card
                child: GestureDetector(
                  onHorizontalDragEnd: (dragEndDetails) {
                    setState(() {
                      if (dragEndDetails.primaryVelocity! < 0) {
                        // Page forwards
                        buildNextImage();
                      } else if (dragEndDetails.primaryVelocity! > 0) {
                        // Page backwards
                        buildPreviousImage();
                      }
                    });
                  },
                  onTap: () {
                    if (CardData().buildDotsIndicator().position == 0) {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const ChatBot(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
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
                    } else if (CardData().buildDotsIndicator().position == 1) {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const ChatPro(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
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
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 5),
                          blurRadius: 5,
                          spreadRadius: 0,
                        )
                      ],
                      image: DecorationImage(
                        image: AssetImage(
                            "${CardData().cardImageUrl[currentSelected]}"),
                        fit: BoxFit.contain,
                      ),
                    ),
                    height: 450,
                    width: MediaQuery.of(context).size.width - 2 * 54,
                    child: Stack(
                      children: [
                        Positioned(
                          right: 0,
                          left: 0,
                          bottom: 0,
                          child: rebuildDotIndicator(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
