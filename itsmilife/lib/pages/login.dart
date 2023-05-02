import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:itsmilife/pages/normal_user/homepage/homepage.dart';
import 'package:itsmilife/pages/register.dart';
import '../services/NetworkManager.dart';
import 'package:itsmilife/pages/common/settings/settings.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:itsmilife/widgets/bottomNavBar.dart';
import 'package:itsmilife/pages/common/settings/languageProvider.dart';
import 'package:itsmilife/pages/common/profile.dart';
import 'package:itsmilife/pages/forgotPass.dart';
import 'package:itsmilife/pages/common/settings/languageProvider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 3;
  double getBiglDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;

  var email = "",
      password = "",
      token = "",
      _id = "",
      username = "",
      role = "",
      firstName = "",
      gender = "",
      lastName = "",
      phoneNumber = "";

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
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
              decoration: const BoxDecoration(
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
                  margin: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.05,
                      MediaQuery.of(context).size.height * 0.40,
                      20,
                      10),
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
                          email = val.toString();
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
                            labelText: lang.lang == "English"
                                ? "Password"
                                : "Mot de passe",
                            enabledBorder: InputBorder.none,
                            labelStyle: const TextStyle(color: Colors.grey)),
                        onChanged: (val) {
                          password = val.toString();
                        },
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordPage(),
                        ),
                      ),
                      child: Text(
                        lang.lang == "English"
                            ? "FORGOT PASSWORD?"
                            : "MOT DE PASSE OUBLIE",
                        style: const TextStyle(
                            color: Color.fromARGB(255, 98, 128, 182),
                            fontSize: 11),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.05,
                      MediaQuery.of(context).size.height * 0.03,
                      20,
                      30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 40,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 98, 128, 182),
                                    Color.fromARGB(255, 98, 128, 182)
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter)),
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
                                  if (val.data['success'] == true) {
                                    ProfileData.id = val.data["user"]["_id"];
                                    ProfileData.username =
                                        val.data["user"]["username"];
                                    ProfileData.email =
                                        val.data["user"]["email"];
                                    ProfileData.password =
                                        val.data["user"]["password"];
                                    ProfileData.role = val.data["user"]["role"];
                                    ProfileData.firstName =
                                        val.data["user"]["firstName"];
                                    ProfileData.gender =
                                        val.data["user"]["gender"];
                                    ProfileData.lastName =
                                        val.data["user"]["lastName"];
                                    if (val.data["user"]["address"] != null) {
                                      ProfileData.address =
                                          val.data["user"]["address"];
                                    } else {
                                      ProfileData.address = "";
                                    }
                                    ProfileData.phoneNumber =
                                        val.data["user"]["phoneNumber"];
                                    ProfileData.age = val.data["user"]["age"];
                                    ProfileData.dark = val.data["user"]["dark"];
                                    ProfileData.language = val.data["user"]["language"];
                                    storage.write(
                                        key: "token", value: val.data['token']);
                                    token = val.data['token'];
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home()),
                                    );
                                  } else
                                    (print(val.data));
                                });
                              },
                              child: Center(
                                child: Text(
                                  lang.lang == "English"
                                      ? "SIGN IN"
                                      : "SE CONNECTER",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: () {},
                        mini: true,
                        elevation: 0,
                        child: const ClipOval(
                          child: Image(
                            image: AssetImage("assets/facebook.png"),
                          ),
                        ),
                      ),
                      FloatingActionButton(
                        backgroundColor: Colors.white,
                        onPressed: () {},
                        mini: true,
                        elevation: 0,
                        child: const Image(
                          image: AssetImage("assets/google.png"),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      lang.lang == "English"
                          ? "DON'T HAVE AN ACCOUNT ?"
                          : "VOUS N'AVEZ PAS ENCORE DE COMPTE ?",
                      style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const RegisterPage(),
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
                              transitionDuration:
                                  const Duration(milliseconds: 300),
                            ),
                          );
                        },
                        child: Text(
                          lang.lang == "English" ? "SIGN UP" : " S'INSCRIRE",
                          style: const TextStyle(
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
