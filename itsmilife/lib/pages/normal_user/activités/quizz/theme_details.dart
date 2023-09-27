import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itsmilife/pages/normal_user/activit%C3%A9s/quizz/logic/quizz_page.dart';
import 'package:itsmilife/pages/normal_user/activit%C3%A9s/quizz/theme.dart';
import '../../../../services/NetworkManager.dart';
import 'quizzBox.dart';
import 'package:itsmilife/pages/common/settings/darkModeProvider.dart';
import 'package:provider/provider.dart';

import 'dart:typed_data';
import 'package:flutter/material.dart';

class ThemeDetailsPage extends StatelessWidget {
  static const routeName = '/themeDetails';

  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<DarkModeProvider>(context);
    final args = ModalRoute.of(context)!.settings.arguments as Category;

    return Scaffold(
      backgroundColor: darkMode.darkMode
          ? const Color.fromARGB(255, 58, 50, 83)
          : Colors.grey[200],
      appBar: AppBar(
        backgroundColor: darkMode.darkMode == true
            ? const Color.fromARGB(255, 32, 32, 32)
            : const Color.fromARGB(255, 224, 224, 224),
        title: Text(
          args.title,
          style: TextStyle(
            color: darkMode.darkMode == true
                ? const Color.fromARGB(255, 224, 224, 224)
                : Color.fromARGB(255, 98, 128, 182),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.back,
            color: darkMode.darkMode == true
                ? const Color.fromARGB(255, 224, 224, 224)
                : Color.fromARGB(255, 98, 128, 182),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<List<quizzBox>>(
        future: getQuizzes(args.id),
        builder:
            (BuildContext context, AsyncSnapshot<List<quizzBox>> snapshot) {
          if (snapshot.hasData) {
            final quizzes = snapshot.data!;
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: quizzes.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final quiz = quizzes[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, QuizPage.routeName,
                          arguments: quizzBox(
                              title: quiz.title,
                              avatar: quiz.avatar,
                              id: quiz.id));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: darkMode.darkMode == true
                            ? Color.fromARGB(255, 100, 100, 100)
                            : Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 98, 128, 182)
                                .withOpacity(0.8), // Couleur de l'ombre
                            spreadRadius: 5, // Étendue de l'ombre
                            blurRadius: 7, // Flou de l'ombre
                            offset: Offset(0,
                                3), // Position de l'ombre (horizontale, verticale)
                          ),
                        ],
                      ),
                      child: FutureBuilder<Uint8List>(
                        future: NetworkManager.getFile("évaluation.png"),
                        builder: (BuildContext context,
                            AsyncSnapshot<Uint8List> snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 40.0,
                                  backgroundColor: Colors
                                      .transparent, // Assurez-vous que le fond est transparent
                                  child: ClipOval(
                                    child: SizedBox(
                                      width:
                                          80.0, // Définissez la largeur souhaitée de l'image
                                      height:
                                          80.0, // Définissez la hauteur souhaitée de l'image
                                      child: Image.memory(
                                        snapshot.data ?? Uint8List(0),
                                        fit: BoxFit
                                            .cover, // Ajustez le mode d'ajustement de l'image selon vos besoins
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15.0),
                                Center(
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    quiz.title,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: darkMode.darkMode == true
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
