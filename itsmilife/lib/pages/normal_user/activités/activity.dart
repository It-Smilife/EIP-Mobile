import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itsmilife/pages/normal_user/Home/widgets/bottom_sheet_header_title.dart';
import 'package:itsmilife/pages/normal_user/Home/widgets/category_grid.dart';
import 'package:itsmilife/pages/normal_user/Home/widgets/date.dart';
import 'package:itsmilife/pages/normal_user/Home/widgets/exercise_tile.dart';
import 'package:itsmilife/pages/normal_user/Home/widgets/greet.dart';
import 'package:itsmilife/pages/normal_user/activit%C3%A9s/forum/forum.dart';
import 'package:itsmilife/pages/normal_user/activit%C3%A9s/quizz/category.dart';
import 'package:itsmilife/pages/normal_user/activit%C3%A9s/quizz/theme.dart';
import 'package:itsmilife/pages/common/settings/darkModeProvider.dart';
import 'package:itsmilife/pages/common/settings/languageProvider.dart';
import 'package:provider/provider.dart';

class ActCategoryPage extends StatelessWidget {
  const ActCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<DarkModeProvider>(context);
    final lang = Provider.of<LanguageProvider>(context);
    var themes = null;
    getThemes().then((value) {
      themes = value;
    });
    return Scaffold(
      backgroundColor: darkMode.darkMode ? const Color.fromARGB(255, 58, 50, 83) : const Color.fromARGB(255, 98, 128, 182),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(
              16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Greet(),
                Date(),
                SizedBox(
                  height: 25.0,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: darkMode.darkMode ? Color.fromARGB(255, 79, 79, 79) : Color.fromARGB(255, 98, 128, 182),
                    blurRadius: 10,
                    //offset: Offset.infinite,
                  ),
                ],
                color: darkMode.darkMode ? const Color.fromARGB(255, 79, 79, 79) : Color.fromARGB(255, 224, 224, 224),
                borderRadius: BorderRadius.only(
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
                    BottomSheetHeaderTitle(
                      titleText: lang.lang == "English" ? "Activities" : 'Activités',
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.1),
                    Expanded(
                      child: ListView(children: [
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) => CategoryPage(themes: themes),
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
                              exercise: 'Quizz',
                              subExercise: lang.lang == "English" ? "Learn more about yourself" : 'Découvrez davantage sur vous',
                              icon: CupertinoIcons.question_square_fill,
                              color: Colors.pink,
                            )),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => const Forum(),
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
                            exercise: 'Forum',
                            subExercise: lang.lang == "English" ? "Share your experiences" : 'Partagez vos expériences',
                            icon: CupertinoIcons.text_bubble_fill,
                            color: Colors.orange,
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
