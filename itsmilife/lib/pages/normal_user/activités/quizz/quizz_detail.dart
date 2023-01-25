import 'package:flutter/material.dart';

import 'category.dart';

class Quizz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 98, 128, 182),
        ),
        child: QuizApp(),
      ),
    );
  }
}

class QuizApp extends StatefulWidget {
  @override
  _QuizWidgetState createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizApp> {
  int _questionIndex = 0;
  List<String> _answers = [];
  List<Question> _questions = [
    Question("What is the capital of France?", ["Paris", "London", "Rome"]),
    Question("What is the currency of Japan?", ["Yen", "Dollar", "Euro"]),
    Question("What is the highest mountain in the world?",
        ["Mount Everest", "K2", "Kangchenjunga"]),
  ];

  void _answerQuestion(String answer) {
    setState(() {
      _answers.add(answer);
      _questionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_questionIndex < _questions.length) {
      return Column(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  _questions[_questionIndex].questionText,
                  style: TextStyle(
                      fontSize: 25.0,
                      color: Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _questions[_questionIndex]
                          .answers
                          .map((answer) => Answer(_answerQuestion, answer))
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
                        children: List.generate(_questions.length, (index) {
                          return Container(
                            margin: EdgeInsets.all(5.0),
                            width: 8.0,
                            height: 8.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _questionIndex == index
                                  ? Color.fromARGB(255, 98, 128, 182)
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
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  "Quizz completed !",
                  style: TextStyle(fontSize: 30.0, color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 238, 238, 238),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _answers.map((answer) => Text(answer)).toList(),
                ),
              ),
            ),
          ),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(
                  Color.fromARGB(255, 255, 255, 255)),
            ),
            onPressed: () => {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      CategoryPage(),
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
                  transitionDuration: Duration(milliseconds: 300),
                ),
              )
            },
            child: Text("Terminé", style: TextStyle(fontSize: 20.0)),
          ),
        ],
      );
    }
  }
}

class Answer extends StatelessWidget {
  final Function callback;
  final String answer;

  Answer(this.callback, this.answer);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 98, 128, 182), // background
          foregroundColor: Colors.white, // foreground
        ),
        onPressed: () => callback(answer),
        child: Text(answer, style: TextStyle(fontSize: 20.0)),
      ),
    );
  }
}

class Question {
  final String questionText;
  final List<String> answers;

  Question(this.questionText, this.answers);
}
