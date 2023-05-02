import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:itsmilife/pages/normal_user/activit%C3%A9s/quizz/logic/quizz_page.dart';
import 'package:itsmilife/pages/normal_user/activit%C3%A9s/quizz/theme.dart';
import '../../../../services/NetworkManager.dart';
import 'quizzBox.dart';

import 'dart:typed_data';
import 'package:flutter/material.dart';

class ThemeDetailsPage extends StatelessWidget {
  static const routeName = '/themeDetails';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Category;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          args.title,
          style: const TextStyle(
            color: Color.fromARGB(255, 98, 128, 182),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 98, 128, 182),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,
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
                        color: Colors.white,
                      ),
                      child: FutureBuilder<Uint8List>(
                        future: NetworkManager.getFile(quiz.avatar),
                        builder: (BuildContext context,
                            AsyncSnapshot<Uint8List> snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundImage: Image.memory(
                                          snapshot.data ?? Uint8List(0))
                                      .image,
                                  radius: 30.0,
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  quiz.title,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
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
