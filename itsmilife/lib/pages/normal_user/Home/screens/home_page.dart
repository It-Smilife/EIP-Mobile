import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itsmilife/pages/normal_user/Home/widgets/bottom_sheet_header_title.dart';
import 'package:itsmilife/pages/normal_user/Home/widgets/date.dart';
import 'package:itsmilife/pages/normal_user/Home/widgets/emoticon_card.dart';
import 'package:itsmilife/pages/normal_user/Home/widgets/exercise_tile.dart';
import 'package:itsmilife/pages/normal_user/Home/widgets/greet.dart';

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
                                onTap: () {},
                                child: ExerciseTile(
                                  exercise: 'Discuter avec Smile',
                                  subExercise: 'Apprenez en plus sur vous',
                                  icon: CupertinoIcons.smiley_fill,
                                  color: Colors.orange,
                                )),
                            InkWell(
                              onTap: () {},
                              child: ExerciseTile(
                                exercise: 'Discuter avec un Pro',
                                subExercise: 'Franchissez le pas',
                                icon: CupertinoIcons.person_alt,
                                color: Colors.pink,
                              ),
                            ),
                            InkWell(
                                onTap: () {},
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
