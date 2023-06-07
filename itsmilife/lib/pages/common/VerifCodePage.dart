import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:itsmilife/pages/common/settings/darkModeProvider.dart';
import 'package:itsmilife/pages/common/verification.dart';
import 'package:itsmilife/pages/login.dart';
import 'package:itsmilife/services/NetworkManager.dart';
import 'package:provider/provider.dart';
import 'package:itsmilife/pages/common/settings/languageProvider.dart';
import 'package:itsmilife/pages/common/profile.dart';
import 'package:itsmilife/services/NetworkManager.dart';
import 'dart:core';

class VerificationPage extends StatefulWidget {
  final String id;
  final String password;
  late int verificationCode;
  final String email;

  VerificationPage({Key? key, required this.id, required this.password, required this.verificationCode, required this.email}) : super(key: key);

  @override
  _VerificationPage createState() => _VerificationPage();
}

class _VerificationPage extends State<VerificationPage> {
  late VerificationPage verification;
  late int count = 0;
  @override
  void initState() {
    super.initState();
    verification = VerificationPage(
      id: widget.id,
      password: widget.password,
      verificationCode: widget.verificationCode,
      email: widget.email,
    );
    // _disabled = true;
    _onButtonPressed();
  }

  final code = TextEditingController();
  bool _disabled = false;
  int _buttonTimer = 60;
  Timer? _timer;
  int state = 0;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _buttonTimer--;
      });
      if (_buttonTimer == 0) {
        setState(() {
          _disabled = false;
        });
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _onButtonPressed() {
    if (!_disabled) {
      setState(() {
        _disabled = true;
        _buttonTimer = 60;
      });
      _startTimer();
      if (state > 0) {
        NetworkManager.putWithoutData("users/" + verification.email + "/update-password-code-by-email").then((value) {
          verification.verificationCode = value.data["message"]["passwordCode"];
        });
      }
      state++;
    } else {
      print("Button is disabled");
    }
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<DarkModeProvider>(context);
    final lang = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: darkMode.darkMode ? const Color.fromARGB(255, 58, 50, 83) : const Color.fromARGB(255, 246, 246, 246),
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.10),
              Text(
                lang.lang == "English" ? "Verification code" : "Code de vérification.",
                style: TextStyle(
                  color: darkMode.darkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.80,
                child: Text(
                  lang.lang == "English" ? "Please enter the code sent by email:" : "Veuillez entrer le code que vous avez reçus par email:",
                  style: TextStyle(
                    fontSize: 20,
                    color: darkMode.darkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.70,
                child: TextField(
                  controller: code,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    labelText: lang.lang == "English" ? 'Enter the code' : "Entrez le code",
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 80),
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
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                child: Row(children: [
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 5,
                        shadowColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: _onButtonPressed,
                      child: _disabled
                          ? Text(
                              '$_buttonTimer s',
                              style: TextStyle(
                                color: _disabled ? Colors.grey : Color.fromARGB(255, 43, 43, 43),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            )
                          : Text(
                              lang.lang == "English" ? "Resend" : "Renvoyer",
                              style: const TextStyle(color: Color.fromARGB(255, 43, 43, 43), fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 5,
                        shadowColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        var codeString = code.text;
                        var codeInt = int.tryParse(codeString);
                        if (codeInt != null && verification.verificationCode == codeInt) {
                          NetworkManager.put('users/' + verification.id + '/update-password', {'newPassword': verification.password}).then((value) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Motde passe oublié"),
                                  content: Text("Votre mot de passe a bien été changé"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("OK"),
                                    ),
                                  ],
                                );
                              },
                            );
                          });
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Erreur"),
                                content: Text("Le code n'est pas valide"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: Text(
                        lang.lang == "English" ? "Send" : "Envoyer",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 43, 43, 43),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
