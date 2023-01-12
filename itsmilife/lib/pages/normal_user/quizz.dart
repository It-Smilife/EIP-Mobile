import 'package:flutter/material.dart';

class Quizz extends StatelessWidget {
  const Quizz({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quizz'),
      ),
      body: const Text("Quizz content"),
    );
  }
}