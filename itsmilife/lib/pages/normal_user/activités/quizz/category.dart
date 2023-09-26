import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itsmilife/pages/normal_user/activit%C3%A9s/activit%C3%A9s.dart';
import 'package:itsmilife/widgets/bottomNavBar.dart';
import '../../../../services/NetworkManager.dart';
import 'theme.dart';
import 'theme_details.dart';
import 'package:itsmilife/pages/common/settings/darkModeProvider.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  final List<dynamic> themes;

  CategoryPage({required this.themes});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late List<Category> _themes = [];

  @override
  void initState() {
    super.initState();
    getThemes().then((value) {
      setState(() {
        _themes = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<DarkModeProvider>(context);

    return Scaffold(
      backgroundColor: darkMode.darkMode
          ? const Color.fromARGB(255, 58, 50, 83)
          : Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: darkMode.darkMode == true
            ? const Color.fromARGB(255, 32, 32, 32)
            : const Color.fromARGB(255, 224, 224, 224),
        title: Text(
          "Quizz",
          style: TextStyle(
            color: darkMode.darkMode == true
                ? const Color.fromARGB(255, 224, 224, 224)
                : Color.fromARGB(255, 98, 128, 182),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.back,
            color: darkMode.darkMode == true
                ? const Color.fromARGB(255, 224, 224, 224)
                : Color.fromARGB(255, 98, 128, 182),
          ),
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    Home(h_index: 0),
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Container(
              decoration: BoxDecoration(
                color: darkMode.darkMode == true
                    ? Color.fromARGB(255, 79, 79, 79)
                    : Color.fromARGB(255, 98, 128, 182),
                border: Border.all(
                  color: darkMode.darkMode == true
                      ? Color.fromARGB(255, 79, 79, 79)
                      : Color.fromARGB(255, 98, 128, 182),
                  width: 0,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 62,
                vertical: 16,
              ),
              child: const Text(
                "Catégories",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05),
              child: GridView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: _themes.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final theme = _themes[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        ThemeDetailsPage.routeName,
                        arguments: Category(
                          title: theme.title,
                          avatar: theme.avatar,
                          id: theme.id,
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: darkMode.darkMode == true
                            ? Color.fromARGB(255, 100, 100, 100)
                            : Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 98, 128, 182)
                                .withOpacity(0.8), // Couleur de l'ombre
                            spreadRadius: 5, // Étendue de l'ombre
                            blurRadius: 7, // Flou de l'ombre
                            offset: Offset(0,
                                3), // Position de l'ombre (horizontale, verticale)
                          ),
                        ],
                      ),
                      child: FutureBuilder<Uint8List>(
                        future: NetworkManager.getFile(theme.avatar),
                        builder: (BuildContext context,
                            AsyncSnapshot<Uint8List> snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundImage: Image.memory(
                                          snapshot.data ?? Uint8List(0))
                                      .image,
                                  radius: 40.0,
                                ),
                                SizedBox(height: 15.0),
                                Text(
                                  theme.title,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: darkMode.darkMode == true
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ],
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
