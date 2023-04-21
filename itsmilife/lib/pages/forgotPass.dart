import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:itsmilife/pages/common/settings/darkModeProvider.dart';
import 'package:itsmilife/services/NetworkManager.dart';
import 'package:provider/provider.dart';
import 'package:itsmilife/pages/common/settings/languageProvider.dart';
import 'package:itsmilife/pages/common/profile.dart';
import 'package:itsmilife/services/NetworkManager.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPage createState() => _ForgotPasswordPage();
}

class _ForgotPasswordPage extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final fieldText1 = TextEditingController();
  final fieldText2 = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<DarkModeProvider>(context);
    final lang = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: darkMode.darkMode
          ? const Color.fromARGB(255, 58, 50, 83)
          : const Color.fromARGB(255, 246, 246, 246),
      appBar: AppBar(
        title: Text(lang.lang == "English" ? "Forgot password" : "Mot de passe oublié"),
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
                      ? "Please enter your email address to reset your password.."
                      : "Veuillez entrer votre adresse mail afin de réinitialiser votre mot de passe.",
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
                        ? 'Enter your email'
                        : "Entrez votre email",
                    enabledBorder: const OutlineInputBorder(
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

                  },
                  child: Text(
                    lang.lang == "English" ? "Send" : "Envoyer",
                    style: const TextStyle(
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
