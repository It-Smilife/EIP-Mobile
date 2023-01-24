import 'package:flutter/material.dart';

List<Map<String, dynamic>> questions = [
  {
    'question': 'What is the capital of France?',
    'answers': ['Paris', 'Rome', 'Madrid', 'Berlin'],
    'correctAnswer': 'Paris'
  },
  {
    'question': 'What is the capital of Italy?',
    'answers': ['Paris', 'Rome', 'Madrid', 'Berlin'],
    'correctAnswer': 'Rome'
  },
  {
    'question': 'What is the capital of Spain?',
    'answers': ['Paris', 'Rome', 'Madrid', 'Berlin'],
    'correctAnswer': 'Madrid'
  },
];

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  int currentQuestion = 0;
  int score = 0;

  void handleAnswer(bool isCorrect) {
    if (isCorrect) {
      score++;
      // show the correct answer feedback
    } else {
      // show the incorrect answer feedback
    }
    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
      });
    } else {
      // navigate to the score screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    )),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Text(
                        questions[currentQuestion]['question'],
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      for (var answer in questions[currentQuestion]['answers'])
                        QuizButton(text: answer),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizButton extends StatelessWidget {
  final String text;

  QuizButton({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Color.fromARGB(255, 35, 46, 202))),
          onPressed: () {},
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
