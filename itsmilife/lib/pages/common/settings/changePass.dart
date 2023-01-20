import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangePassPage extends StatefulWidget {
  const ChangePassPage({super.key});

  @override
  _ChangePassPage createState() => _ChangePassPage();
}

class _ChangePassPage extends State<ChangePassPage> {
  final _formKey = GlobalKey<FormState>();

  late String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(CupertinoIcons.back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            const Text('Texte'),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.70,
              child: const TextField(
                decoration: InputDecoration(),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.70,
              child: const TextField(),
            ),
            ElevatedButton(
              child: Text('Bouton'),
              onPressed: () {},
            ),
          ],
        )));
  }
}
