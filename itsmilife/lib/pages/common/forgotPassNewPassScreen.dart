import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:itsmilife/pages/common/VerifCodePage.dart';
import 'package:itsmilife/pages/common/settings/darkModeProvider.dart';
import 'package:itsmilife/pages/login.dart';
import 'package:itsmilife/services/NetworkManager.dart';
import 'package:provider/provider.dart';
import 'package:itsmilife/pages/common/settings/languageProvider.dart';
import 'dart:core';

class ForgotPassNewPassScreen extends StatefulWidget {
  const ForgotPassNewPassScreen({required this.email, required this.id, super.key});

  final String email;
  final String id;

  @override
  State<ForgotPassNewPassScreen> createState() => _ForgotPassNewPassScreenState();
}

class _ForgotPassNewPassScreenState extends State<ForgotPassNewPassScreen> {
  final _formKey = GlobalKey<FormState>();
  final newPass = TextEditingController();
  final confirmPass = TextEditingController();
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
                      ? "Please enter the new password that will be used to access your account."
                      : "Veuillez entrer le nouveau mot de passe qui sera utilisé pour accéder à votre compte.",
                  style: TextStyle(fontSize: 16, color: darkMode.darkMode ? Colors.white : Colors.black),
                ),
              ),
              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 40),
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
                    const SizedBox(height: 50),
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
                              width: 0,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
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
                      NetworkManager.put("users/${widget.id}/update-password", {"newPassword": newPass.text}).then((val) {
                        if (val.data["success"] == true) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
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
