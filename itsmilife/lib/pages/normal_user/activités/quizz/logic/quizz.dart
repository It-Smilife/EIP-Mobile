import 'package:flutter/material.dart';

import './answers.dart';
import './questions.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, dynamic>> questions;
  final int questionIndex;
  final Function answerQuestion;

  const Quiz({
    Key? key,
    required this.questions,
    required this.answerQuestion,
    required this.questionIndex,
  }) : super(key: key);

  @override
Widget build(BuildContext context) {
  return Column(children: [
    Expanded(
      child: Container(
        margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.09),
        child: Center(
          child: Question(
            questions[questionIndex]['content'],
          ),
        ),
      ),
    ),
    Expanded(
      flex: 2,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 40.0, right: 40.0, top: 40.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Nombre de colonnes dans la grille
                  crossAxisSpacing: 0.0, // Espacement horizontal entre les éléments (à 0)
                  mainAxisSpacing: 0.0, // Espacement vertical entre les éléments (à 0)
                ),
                itemCount: (questions[questionIndex]['response'] as List<dynamic>).length,
                itemBuilder: (context, index) {
                  var answer = (questions[questionIndex]['response'] as List<dynamic>)[index];
                  return Center( // Centrer chaque réponse
                    child: Answer(
                      () => answerQuestion(answer['score']),
                      answer['content'],
                    ),
                  );
                },
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(questions.length, (index) {
                    return Container(
                      margin: EdgeInsets.all(5.0),
                      width: 8.0,
                      height: 8.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: questionIndex == index
                            ? const Color.fromARGB(255, 98, 128, 182)
                            : Colors.grey,
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ]);
}

}
