import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangePassPage extends StatefulWidget {
  const ChangePassPage({super.key});

  @override
  _ChangePassPage createState() => _ChangePassPage();
}

class _ChangePassPage extends State<ChangePassPage> {
  final _formKey = GlobalKey<FormState>();
  final fieldText1 = TextEditingController();
  final fieldText2 = TextEditingController();

  @override
  void dispose() {
    fieldText1.dispose();
    fieldText2.dispose();
    super.dispose();
  }

  void clearText() {
    fieldText1.clear();
    fieldText2.clear();
  }

  late String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Password"),
          leading: IconButton(
            icon: const Icon(CupertinoIcons.back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
            child: Center(
                child: Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.10),
            const Text(
              "Reset your password.",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.80,
              child: const Text(
                "Your password must have at least 6 caracters and must contain numbers and special caracters.",
                style: TextStyle(fontSize: 15),
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.70,
              child: TextField(
                controller: fieldText1,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter the current password'),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.70,
              child: TextField(
                controller: fieldText2,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter the new password'),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 120),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 98, 128, 182),
                borderRadius: BorderRadius.circular(9),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    // spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(3, 3), // changes position of shadow
                  ),
                ],
              ),
              child: TextButton(
                style:
                    TextButton.styleFrom(backgroundColor: Colors.transparent),
                onPressed: () {
                  clearText();
                },
                child: const Text(
                  "Save",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            )
          ],
        ))));
  }
}
