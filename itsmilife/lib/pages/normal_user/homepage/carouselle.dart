import 'package:flutter/material.dart';
import 'package:itsmilife/pages/normal_user/chat/chatpro.dart';

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
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 400,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        new BoxShadow(
                          color: Color.fromARGB(255, 98, 128, 182),
                          offset: new Offset(0.0, 0.0),
                        ),
                      ],
                    ),
                    child: Center(
                        child: Text(_title, style: TextStyle(fontSize: 24, color: Colors.white))),
                  )),
              Padding(
                padding: const EdgeInsets.all(0),

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
                            transitionDuration: Duration(milliseconds: 300),
                          ),
                        );
                      } else if (CardData().buildDotsIndicator().position ==
                          1) {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    ChatPro(),
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
                            transitionDuration: Duration(milliseconds: 300),
                          ),
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
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
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
