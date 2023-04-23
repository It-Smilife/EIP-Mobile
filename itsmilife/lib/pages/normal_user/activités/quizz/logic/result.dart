import 'package:flutter/material.dart';
import 'package:itsmilife/pages/normal_user/activit%C3%A9s/activit%C3%A9s.dart';
import 'package:itsmilife/pages/normal_user/activit%C3%A9s/quizz/category.dart';
import 'package:itsmilife/pages/normal_user/activit%C3%A9s/quizz/theme_details.dart';
import 'package:itsmilife/widgets/bottomNavBar.dart';

import '../theme.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function resetHandler;
  final List<Map<String, dynamic>> results;

  const Result(this.resultScore, this.resetHandler, this.results, {Key? key})
      : super(key: key);

  //Remark Logic
  Text get resultPhrase {
    Text resultText;
    if (resultScore <= 15) {
      resultText = Text(
        results[0]["content"],
        style: const TextStyle(
                fontWeight: FontWeight.bold,
            fontSize: 17, color: Colors.white, decoration: TextDecoration.none, ),
        textAlign: TextAlign.center,
      );
    } else if (resultScore >= 16 && resultScore <= 31) {
      resultText = Text(
        results[1]["content"],
        style: const TextStyle(
            fontSize: 17, color: Colors.white, decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
            ),
        textAlign: TextAlign.center,
      );
    } else {
      resultText = Text(
        results[2]["content"],
        style: const TextStyle(
                fontWeight: FontWeight.bold,
            fontSize: 17, color: Colors.white, decoration: TextDecoration.none, ),
        textAlign: TextAlign.center,
      );
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    late List<Category> _themes = [];
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          resultPhrase, //Text
          SizedBox(height: MediaQuery.of(context).size.height * 0.2),
          const Text(
            '',
            style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                decoration: TextDecoration.none),
            textAlign: TextAlign.center,
          ), //Text
          TextButton(
            child: const Text(
              'Recommencer le quizz!',
              style: TextStyle(
                  fontSize: 18, fontFamily: 'Fontstart', color: Colors.white),
            ), //Text
            onPressed: () => resetHandler(),
          ),
          TextButton(
              child: const Text(
                'Retour',
                style: TextStyle(
                    fontSize: 17, fontFamily: 'Fontstart', color: Colors.white),
              ), //Text
              onPressed: () => {
                    getThemes().then((value) {
                      _themes = value;
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  CategoryPage(themes: _themes),
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
                    })
                  }), //FlatBu //FlatButton
        ], //<Widget>[]
      ), //Column
    ); //Center
  }
}
