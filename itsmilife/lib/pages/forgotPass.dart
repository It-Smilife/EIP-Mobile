import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:itsmilife/pages/common/settings/darkModeProvider.dart';
import 'package:itsmilife/pages/common/verification.dart';
import 'package:itsmilife/services/NetworkManager.dart';
import 'package:provider/provider.dart';
import 'package:itsmilife/pages/common/settings/languageProvider.dart';
import 'package:itsmilife/pages/common/profile.dart';
import 'package:itsmilife/services/NetworkManager.dart';
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
        preferredSize: Size.fromHeight(56.0), // La hauteur d'origine de l'AppBar.
        child: AppBar(
          shape: RoundedRectangleBorder(
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
                      ? "Please enter the email associated with your account, the new password and we'll send you an email with a reboot code."
                      : "Veuillez entrer l'adresse email associée à votre compte, le nouveau mot de passe et nous vous enverrons un email avec un code de réinitialisation.",
                  style: TextStyle(fontSize: 16, color: darkMode.darkMode ? Colors.white : Colors.black),
                ),
              ),
              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.70,
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
                              width: 2,
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 3,
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Text(
                        lang.lang == "English" ? "Enter the new password" : "Saisissez le nouveau mot de passe",
                        style: TextStyle(
                          color: darkMode.darkMode ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.70,
                      child: TextFormField(
                        controller: newPass,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return lang.lang == "English" ? "Please enter the new password" : "Entrez le nouveau mot de passe";
                          }
                          if (value.length < 6) {
                            return lang.lang == "English" ? "Password must contain at least 6 characters" : "Le mot de passe doit contenir au moins 6 caractères";
                          }
                          if (!value.contains(RegExp(r'[A-Z]'))) {
                            return lang.lang == "English" ? "Password must contain at least one uppercase letter" : "Le mot de passe doit contenir au moins une lettre majuscule";
                          }
                          if (!value.contains(RegExp(r'[0-9]'))) {
                            return lang.lang == "English" ? "Password must contain at least one digit" : "Le mot de passe doit contenir au moins un chiffre";
                          }
                          if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                            return lang.lang == "English" ? "Password must contain at least one special character" : "Le mot de passe doit contenir au moins un caractère spécial";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          labelText: lang.lang == "English" ? 'New password' : "Nouveau mot de passe",
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(15),
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
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.70,
                      child: TextFormField(
                        controller: confirmPass,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return lang.lang == "English" ? "Please confirm the new password" : "Confirmez le nouveau mot de passe";
                          }
                          if (value != newPass.text) {
                            return lang.lang == "English" ? "Passwords do not match" : "Les mots de passe ne sont pas identiques";
                          }
                          if (value.length < 6) {
                            return lang.lang == "English" ? "Password must contain at least 6 characters" : "Le mot de passe doit contenir au moins 6 caractères";
                          }
                          if (!value.contains(RegExp(r'[A-Z]'))) {
                            return lang.lang == "English" ? "Password must contain at least one uppercase letter" : "Le mot de passe doit contenir au moins une lettre majuscule";
                          }
                          if (!value.contains(RegExp(r'[0-9]'))) {
                            return lang.lang == "English" ? "Password must contain at least one digit" : "Le mot de passe doit contenir au moins un chiffre";
                          }
                          if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                            return lang.lang == "English" ? "Password must contain at least one special character" : "Le mot de passe doit contenir au moins un caractère spécial";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          labelText: lang.lang == "English" ? 'Confirm the password' : "Confirmez le mot de passe",
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 3,
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
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
                    print("ok");
                    if (_formKey.currentState!.validate()) {
                      NetworkManager.putWithoutData("users/" + email.text + "/update-password-code-by-email").then((value) {
                        if (value.data["success"] == true) {
                          NetworkManager.get("users/email/" + email.text).then((value) {
                            if (value.data["success"] == true) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VerificationPage(
                                    id: value.data["message"]["_id"].toString(),
                                    verificationCode: value.data["message"]["passwordCode"],
                                    password: newPass.text,
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
