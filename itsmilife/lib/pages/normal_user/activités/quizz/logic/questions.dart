import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String content;

  const Question(this.content, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget> [ 
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),  
        Text(
        content, style: const TextStyle(fontSize: 18, color: Colors.white, decoration: TextDecoration.none, fontWeight: FontWeight.bold, fontFamily: 'Fontstart'), textAlign: TextAlign.center,), //Text
        ],
      ),
    ); //Container
  }
}