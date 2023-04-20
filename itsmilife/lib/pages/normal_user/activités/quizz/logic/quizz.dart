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
          margin: EdgeInsets.all(20.0),
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
              child: Stack(children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        (questions[questionIndex]['response'] as List<dynamic>)
                            .map((answer) => Answer(
                                  () => answerQuestion(answer['score']),
                                  answer['content'],
                                ))
                            .toList(),
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
              ])))
    ]);
  }
}
