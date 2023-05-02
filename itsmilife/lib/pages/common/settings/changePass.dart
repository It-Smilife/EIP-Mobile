import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itsmilife/pages/common/settings/darkModeProvider.dart';
import 'package:itsmilife/services/NetworkManager.dart';
import 'package:provider/provider.dart';
import 'package:itsmilife/pages/common/settings/languageProvider.dart';
import 'package:itsmilife/pages/common/profile.dart';
import 'package:itsmilife/services/NetworkManager.dart';

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

  var email, pass, id = "";

  void verifyUser(String oldPass, String newPass) async {
    email = ProfileData.email;
    id = ProfileData.id;
    await NetworkManager.post(
        "authenticate", {"email": email, "password": oldPass}).then((value) {
      if (value.data["success"] == true) {
        NetworkManager.put("users/$id", {"email": email, "password": newPass})
            .then((val) {
          print(val.data["message"]);
        });
      }
    });
    clearText();
  }

  late String _password;

  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<DarkModeProvider>(context);
    final lang = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: darkMode.darkMode
          ? const Color.fromARGB(255, 58, 50, 83)
          : const Color.fromARGB(255, 246, 246, 246),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          lang.lang == "English" ? "Password" : "Mot de passe",
          style: const TextStyle(
            color: Color.fromARGB(255, 98, 128, 182),
          ),
        ),
        leading: IconButton(
          color: Color.fromARGB(255, 98, 128, 182),
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
              Text(
                lang.lang == "English"
                    ? "Reset your password."
                    : "Réintialisez votre mot de passe",
                style: TextStyle(
                  color: darkMode.darkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.80,
                child: Text(
                  lang.lang == "English"
                      ? "Your password must have at least 6 caracters and must contain numbers and special caracters."
                      : "Votre mot de passe doit contenir au moins 6 caractères et dot contenir des chiffres et des caractères spéciaux.",
                  style: TextStyle(
                      fontSize: 15,
                      color: darkMode.darkMode ? Colors.white : Colors.black),
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.70,
                child: TextField(
                  controller: fieldText1,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: lang.lang == "English"
                        ? 'Enter the current password'
                        : "Entrez le mot de passe actuel",
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.70,
                child: TextField(
                  controller: fieldText2,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: lang.lang == "English"
                        ? "Enter the new password"
                        : "Entrez le nouveau mot de passe",
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 120),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 98, 128, 182),
                  borderRadius: BorderRadius.circular(10),
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
                    verifyUser(
                        fieldText1.text.toString(), fieldText2.text.toString());
                  },
                  child: Text(
                    lang.lang == "English" ? "Save" : "Sauvegarder",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
