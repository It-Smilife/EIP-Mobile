import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function resetHandler;
  final List<Map<String,  dynamic>> results;

  const Result(this.resultScore, this.resetHandler, this.results, {Key? key})
      : super(key: key);

  //Remark Logic
  Text get resultPhrase {
    Text resultText;
    if (resultScore <= 15) {
      resultText = Text(
        results[0]["content"],
         style: const TextStyle(fontSize: 20, color: Colors.white, decoration: TextDecoration.none), textAlign: TextAlign.center,
      );
    } else if (resultScore >= 16 && resultScore <= 31) {
      resultText = Text(
        results[1]["content"],
         style: const TextStyle(fontSize: 20, color: Colors.white, decoration: TextDecoration.none), textAlign: TextAlign.center,
      );
    } else {
      resultText = Text(
        results[2]["content"],
         style: const TextStyle(fontSize: 20, color: Colors.white, decoration: TextDecoration.none), textAlign: TextAlign.center,
      );
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          resultPhrase, //Text
          const Text(
            '',
            style: const TextStyle(fontSize: 30, color: Colors.white, decoration: TextDecoration.none), textAlign: TextAlign.center,
          ), //Text
          TextButton(
            child: const Text(
              'Recommencer le quizz!',
              style: TextStyle(fontSize: 20, fontFamily: 'Fontstart', color: Colors.white),
            ), //Text
            onPressed: () => resetHandler(),
          ), //FlatButton
        ], //<Widget>[]
      ), //Column
    ); //Center
  }
}
