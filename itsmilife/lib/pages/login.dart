import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:itsmilife/pages/register.dart';
import '../services/NetworkManager.dart';
import 'package:itsmilife/pages/common/settings.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 3;
  double getBiglDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;

  var email, password, token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      body: Stack(
        children: <Widget>[
          Positioned(
            left: 25,
            top: -getBiglDiameter(context) / 4,
            child: Container(
              width: getBiglDiameter(context),
              height: getBiglDiameter(context),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 255, 255, 255),
                    Color.fromARGB(255, 98, 128, 182)
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              child: Stack(
                children: [
                  Image.asset(
                    'assets/logo.png',
                    alignment: Alignment.centerRight,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: -getBiglDiameter(context) / 2,
            bottom: -getBiglDiameter(context) / 2,
            child: Container(
              width: getBiglDiameter(context),
              height: getBiglDiameter(context),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xFFF3E9EE)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ListView(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      //border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.fromLTRB(20, 300, 20, 10),
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 25),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                            icon: const Icon(
                              Icons.email,
                              color: Color.fromARGB(255, 98, 128, 182),
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade100)),
                            labelText: "Email",
                            enabledBorder: InputBorder.none,
                            labelStyle: const TextStyle(color: Colors.grey)),
                        onChanged: (val) {
                          email = val;
                        },
                      ),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                            icon: const Icon(
                              Icons.vpn_key,
                              color: Color.fromARGB(255, 98, 128, 182),
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade100)),
                            labelText: "Password",
                            enabledBorder: InputBorder.none,
                            labelStyle: const TextStyle(color: Colors.grey)),
                        onChanged: (val) {
                          password = val;
                        },
                      )
                    ],
                  ),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                        child: const Text(
                          "FORGOT PASSWORD?",
                          style: TextStyle(
                              color: Color.fromARGB(255, 98, 128, 182),
                              fontSize: 11),
                        ))),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 40,
                        child: Container(
                          child: Material(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              splashColor: Colors.amber,
                              onTap: () {
                                NetworkManager.post('authenticate', {
                                  "email": email,
                                  "password": password
                                }).then((val) {
                                  print(val.toString());
                                  if (val.data['success']) {
                                    storage.write(
                                        key: "token", value: val.data['token']);
                                    token = val.data['token'];
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SettingsPage()),
                                    );
                                  }
                                });
                              },
                              child: const Center(
                                child: Text(
                                  "SIGN IN",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 98, 128, 182),
                                    Color.fromARGB(255, 98, 128, 182)
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter)),
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: () {},
                        mini: true,
                        elevation: 0,
                        child: ClipOval(
                          child: Image(
                            image: AssetImage("assets/facebook.png"),
                          ),
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: () {},
                        mini: true,
                        elevation: 0,
                        child: const Image(
                          image: AssetImage("assets/twitter.png"),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "DON'T HAVE AN ACCOUNT ? ",
                      style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      RegisterPage(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(1, 0),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                );
                              },
                              transitionDuration: Duration(milliseconds: 300),
                            ),
                          );
                        },
                        child: Text(
                          " SIGN UP",
                          style: TextStyle(
                              fontSize: 11,
                              color: Color.fromARGB(255, 98, 128, 182),
                              fontWeight: FontWeight.w700),
                        )),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
