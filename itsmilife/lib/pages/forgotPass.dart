import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:itsmilife/pages/common/settings/darkModeProvider.dart';
import 'package:itsmilife/services/NetworkManager.dart';
import 'package:provider/provider.dart';
import 'package:itsmilife/pages/common/settings/languageProvider.dart';
import 'dart:core';

import 'common/VerifCodePage.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPage createState() => _ForgotPasswordPage();
}

class _ForgotPasswordPage extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final newPass = TextEditingController();
  final confirmPass = TextEditingController();

  RegExp emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');

  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<DarkModeProvider>(context);
    final lang = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 246, 246),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0), // La hauteur d'origine de l'AppBar.
        child: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15), // Ici, vous pouvez spécifier le rayon.
            ),
          ),
          title: Text(
            lang.lang == "English" ? "Forgot password" : "Mot de passe oublié",
            style: const TextStyle(
              color: Color.fromARGB(255, 98, 128, 182),
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              CupertinoIcons.back,
              color: Color.fromARGB(255, 98, 128, 182),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.white,
          elevation: 2,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: Text(
                  lang.lang == "English" ? "Reset your password." : "Réintialisez votre mot de passe",
                  style: TextStyle(
                    color: darkMode.darkMode ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 27,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: Text(
                  lang.lang == "English"
                      ? "Please enter the email associated with your account and we'll send you an email with a reboot code."
                      : "Veuillez entrer l'adresse email associée à votre compte et nous vous enverrons un email avec un code de réinitialisation.",
                  style: TextStyle(fontSize: 16, color: darkMode.darkMode ? Colors.white : Colors.black),
                ),
              ),
              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: const Offset(1, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: email,
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return lang.lang == "English" ? "Please enter your email" : "Entrez votre email";
                          }
                          if (!emailRegex.hasMatch(value)) {
                            return lang.lang == "English" ? "Please enter a valid email address" : "Veuillez entrer une adresse email valide";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          labelText: lang.lang == "English" ? 'Enter your email' : "Entrez votre email",
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 0,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 0,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
              const SizedBox(height: 80),
              Container(
                width: MediaQuery.of(context).size.width * 0.90,
                // margin: const EdgeInsets.symmetric(horizontal: 120),
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
                  style: TextButton.styleFrom(backgroundColor: Colors.transparent),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      NetworkManager.putWithoutData("users/${email.text}/update-password-code-by-email").then((value) {
                        if (value.data["success"] == true) {
                          NetworkManager.get("users/email/${email.text}").then((value) {
                            if (value.data["success"] == true) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VerificationPage(
                                    id: value.data["message"]["_id"],
                                    verificationCode: value.data["message"]["passwordCode"],
                                    email: value.data["message"]["email"],
                                  ),
                                ),
                              );
                            }
                          });
                        }
                      });
                    }
                  },
                  child: Text(
                    lang.lang == "English" ? "Send" : "Envoyer",
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
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
