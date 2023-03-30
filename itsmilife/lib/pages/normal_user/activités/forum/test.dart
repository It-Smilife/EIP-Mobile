import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itsmilife/pages/normal_user/activités/forum/models/post_model.dart';
import 'package:itsmilife/pages/normal_user/activités/forum/models/author_model.dart';
import 'package:itsmilife/pages/normal_user/activités/forum/models/replies_model.dart';
import 'package:itsmilife/pages/normal_user/activités/forum/forum.dart';

class AddQuestionForm extends StatefulWidget {
  final List<Post> questions;

  const AddQuestionForm({Key? key, required this.questions}) : super(key: key);

  @override
  _AddQuestionFormState createState() => _AddQuestionFormState();
}

class _AddQuestionFormState extends State<AddQuestionForm> {
  final _formKey = GlobalKey<FormState>();
  late String _author;
  late String _question;
  late String _content;
  late DateTime _createdAt;
  late int _views;
  late int _votes;
  late int _repliesCount;

  void checkQuestions(List<Post> questions) {
    questions.forEach((question) {
      // print("------------------------");
      // print(question.author.name);
      // print(question.question);
      // print(question.content);
      // print(question.views);
      // print(question.votes);
      // print(question.replies);
      // Afficher les autres propriétés de l'objet Question
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.clear,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const Forum(),
              ),
            );
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Author'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the author';
                }
                return null;
              },
              onSaved: (value) => _author = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Question'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the question';
                }
                return null;
              },
              onSaved: (value) => _question = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Content'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the content';
                }
                return null;
              },
              onSaved: (value) => _content = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Views'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the views';
                }
                return null;
              },
              onSaved: (value) => _views = int.parse(value!),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Votes'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the votes';
                }
                return null;
              },
              onSaved: (value) => _votes = int.parse(value!),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Replies Count'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the replies count';
                }
                return null;
              },
              onSaved: (value) => _repliesCount = int.parse(value!),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // setState(() {
                  //   widget.questions.add(Question(
                  //       user: mark,
                  //       title: _question,
                  //       content: _content,
                  //       date: DateTime.now().toString(),
                  //       views: _views,
                  //       // votes: _votes,
                  //       repliesCount: _repliesCount,
                  //       comments: replies));
                  // });
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Forum()));
                }
              },
              child: const Text('Submit'),
            ),
            ElevatedButton(
              onPressed: () => {widget.questions.clear()},
              child: Text("Clear"),
            ),
            // ElevatedButton(
            //   onPressed: () => {checkQuestions(questions)},
            //   child: Text("print"),
            // ),
          ],
        ),
      ),
    );
  }
}
