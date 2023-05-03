// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:itsmilife/pages/normal_user/activit%C3%A9s/quizz/quizzBox.dart';
import '../../../../../services/NetworkManager.dart';
import 'quizz.dart';
import 'result.dart';
import 'package:itsmilife/pages/common/settings/darkModeProvider.dart';
import 'package:provider/provider.dart';

class QuizPage extends StatefulWidget {
  static const routeName = '/quizPage';
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _SlidePageRoute<T> extends PageRouteBuilder<T> {
  final Widget child;
  final Color backgroundColor;

  _SlidePageRoute({required this.child, required this.backgroundColor})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return Container(
              color: backgroundColor,
              child: child,
            );
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return child;
          },
        );
}

class _QuizPageState extends State<QuizPage> {
  int _questionIndex = 0;
  int _score = 0;
  late List<Map<String, dynamic>> _questions;
  late String title;

  void _answerQuestion(int score) {
    _score += score;
    setState(() {
      _questionIndex++;
      print(_questionIndex);
    });

    // Add this line to push the next question page with a slide transition.
    Navigator.push(
      context,
      _SlidePageRoute(
        child: (_questionIndex < _questions.length)
            ? Quiz(
                questions: _questions,
                questionIndex: _questionIndex,
                answerQuestion: _answerQuestion,
              )
            : Result(_score, _resetQuiz, _questions[0]["results"]),
        backgroundColor: const Color.fromARGB(255, 98, 128, 182),
      ),
    );
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      print(_questionIndex);
      _score = 0;
    });
    Navigator.push(
      context,
      _SlidePageRoute(
        child: Quiz(
          questions: _questions,
          questionIndex: _questionIndex,
          answerQuestion: _answerQuestion,
        ),
        backgroundColor: const Color.fromARGB(255, 98, 128, 182),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _loadQuestions() async {
    final args = ModalRoute.of(context)!.settings.arguments as quizzBox;

    final response = await NetworkManager.get('quizzes/' + args.id);
    if (response.data['success'] == true) {
      final results =
          List<Map<String, dynamic>>.from(response.data['message']['results']);
      final questions = List<Map<String, dynamic>>.from(
          response.data['message']['questions']);
      for (var question in questions) {
        if (question['content'] is String) {
          question['content'] = question['content'];
        }
        for (var i = 0; i < question['response'].length; i++) {
          if (question['response'][i]['content'] is String) {
            question['response'][i]['content'] =
                question['response'][i]['content'];
            question['response'][i]['score'] = question['response'][i]['score'];
          }
        }
      }
      questions[0]['results'] = results;
      print(questions[0]['results']);
      return questions;
    } else {
      throw Exception('Failed to load questions');
    }
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<DarkModeProvider>(context);
    final args = ModalRoute.of(context)!.settings.arguments as quizzBox;
    title = args.title;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 98, 128, 182),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _loadQuestions(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            print(snapshot);
            return Center(
              child: Text('Error loading questions',
                  style: TextStyle(color: Colors.white)),
            );
          } else {
            _questions = snapshot.data!;
            return _questionIndex < _questions.length
                ? Quiz(
                    questions: _questions,
                    questionIndex: _questionIndex,
                    answerQuestion: _answerQuestion,
                  )
                : Result(_score, _resetQuiz, _questions[0]["results"]);
          }
        },
      ),
    );
  }
}
