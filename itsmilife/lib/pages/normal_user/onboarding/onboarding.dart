import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:itsmilife/pages/common/profile.dart';
import 'package:itsmilife/services/NetworkManager.dart';
import '../homepage/homepage.dart';
import 'package:itsmilife/widgets/bottomNavBar.dart';
import 'styles.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnBoarding> {
  final int _numPages = 3;
  String _selectedGender = "male";
  late String _nom;
  late String _prenom;
  late int _age;
  late String _phoneNumber;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color:
            isActive ? Colors.white : Colors.grey,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                Color(0xFF3594DD),
                Color(0xFF4563DB),
                Color(0xFF4563DB),
                Color.fromARGB(255, 98, 128, 182),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.01),
            child: SingleChildScrollView(
          child: 
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: PageView(
                    physics: const ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.height * 0.015),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/logo.png',
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                width: MediaQuery.of(context).size.height * 0.4,
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05),
                            Center(
                              child: Text(
                                "Bienvenue sur It'Smilife !",
                                style: kTitleStyle,
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.025),
                            Center(
                              child: Text(
                                "Avant de pouvoir vous lancer dans l'aventure It'Smilife, vous devez renseigner les informations nécessaires.",
                                style: kSubtitleStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.06,
                            right: MediaQuery.of(context).size.width * 0.1,
                            left: MediaQuery.of(context).size.width * 0.1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/logosmile.png',
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                width: MediaQuery.of(context).size.height * 0.4,
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.001),
                            Center(
                              child: Text(
                                'Bonjour ' +
                                    ProfileData.username +
                                    ',  je me surnomme Smile',
                                style: kTitleStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.025),
                            Center(
                              child: Text(
                                'Ma mission est de vous accompagner tout au long de votre aventure. Diriger vous vers la page suivante afin de finaliser votre inscription.',
                                style: kSubtitleStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.height * 0.025),
                        child:
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                  
                                 Center(
                                child: Text(
                                  'Informations personnelles',
                                  style: kTitleStyle,
                                ),
                              ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.12),

                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(0, 2),
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                    onChanged: (val) => _nom = val,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '  Nom',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.035),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(0, 2),
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                    onChanged: (val) => _prenom = val,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '  Prénom',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.035),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(0, 2),
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                    onChanged: (val) => _age = int.parse(val),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '  Age',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.035),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(0, 2),
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                    onChanged: (val) => _phoneNumber = val,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '  Numéro de telephone',
                                    ),
                                  ),
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height *
                                        0.035),
                                Container(
                                  width: MediaQuery.of(context).size.height *
                                        0.15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(0, 2),
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                  ),
                                  child: Center(child: DropdownButton<String>(
                                    hint: _selectedGender == null
                                        ? const Text("  Select Gender")
                                        : Text(_selectedGender),
                                    value: _selectedGender,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedGender = newValue!;
                                      });
                                    },
                                    items: [
                                      ['male', 'homme'],
                                      ['female', 'femme'],
                                      ['other', 'autres']
                                    ].map<DropdownMenuItem<String>>((value) {
                                      return DropdownMenuItem<String>(
                                        value: value[0],
                                        child: Text(value[1]),
                                      );
                                    }).toList(),
                                  ),
                                  ),
                                ),
                              ],
                        ),
                      ),
                      
                    ],
                  ),
                ),
                 SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
              ],
            ),
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
              height: 100.0,
              width: double.infinity,
              color: Colors.white,
              child: GestureDetector(
                onTap: () => {
                  ProfileData.lastName = _nom,
                  ProfileData.firstName = _prenom,
                  ProfileData.age = _age,
                  ProfileData.phoneNumber = _phoneNumber,
                  ProfileData.gender = _selectedGender,
                  NetworkManager.put("users/" + ProfileData.id, {
                    "firstName": _nom,
                    "lastName": _prenom,
                    "age": _age,
                    "gender": _selectedGender,
                    "phoneNumber": _phoneNumber
                  }).then(
                    (val) {
                      print("MESSAGE: " + val.data['message'].toString());
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  Home(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(1, 0),
                                end: Offset.zero,
                              ).animate(animation),
                              child: child,
                            );
                          },
                          transitionDuration: const Duration(milliseconds: 300),
                        ),
                      );
                    },
                  ),
                },
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 30.0),
                    child: Text(
                      'Get started',
                      style: TextStyle(
                        color: Color.fromARGB(255, 98, 128, 182),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : const Text(''),
    );
  }
}
