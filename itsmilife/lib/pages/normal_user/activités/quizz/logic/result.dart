import 'package:flutter/material.dart';
import 'package:itsmilife/pages/normal_user/activit%C3%A9s/activit%C3%A9s.dart';
import 'package:itsmilife/pages/normal_user/activit%C3%A9s/quizz/category.dart';
import 'package:itsmilife/pages/normal_user/activit%C3%A9s/quizz/theme_details.dart';
import 'package:itsmilife/widgets/bottomNavBar.dart';
import 'package:provider/provider.dart';
import 'package:itsmilife/pages/common/settings/languageProvider.dart';

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
            fontSize: 17, color: Colors.black, decoration: TextDecoration.none, ),
        textAlign: TextAlign.center,
      );
    } else if (resultScore >= 16 && resultScore <= 31) {
      resultText = Text(
        results[1]["content"],
        style: const TextStyle(
            fontSize: 17, color: Colors.black, decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
            ),
        textAlign: TextAlign.center,
      );
    } else {
      resultText = Text(
        results[2]["content"],
        style: const TextStyle(
                fontWeight: FontWeight.bold,
            fontSize: 17, color: Colors.black, decoration: TextDecoration.none, ),
        textAlign: TextAlign.center,
      );
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    late List<Category> _themes = [];
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.024),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.blueGrey,
                          offset: Offset(0, 5),
                          blurRadius: 5,
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1, bottom: MediaQuery.of(context).size.height * 0.1),
                    child: resultPhrase
                  ),
                ),
              ),
          const Text(
            '',
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                decoration: TextDecoration.none),
            textAlign: TextAlign.center,
          ), //Text
          TextButton(
            child: Text(
              lang.lang == "English" ? "Restart the quizz !" : "Recommencer le quizz !",
              style: const TextStyle(
                  fontSize: 18, fontFamily: 'Fontstart', color: Colors.white, fontWeight: FontWeight.bold),
            ), //Text
            onPressed: () => resetHandler(),
          ),
          TextButton(
              child: Text(
                lang.lang == "English" ? "Back" : 'Retour',
                style: const TextStyle(
                    fontSize: 17, fontFamily: 'Fontstart', color: Colors.white, fontWeight: FontWeight.bold),
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
