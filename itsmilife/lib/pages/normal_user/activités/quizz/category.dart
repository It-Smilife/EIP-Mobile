import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:itsmilife/pages/normal_user/activit%C3%A9s/activit%C3%A9s.dart';
import 'package:itsmilife/widgets/bottomNavBar.dart';
import '../../../../services/NetworkManager.dart';
import 'theme.dart';
import 'theme_details.dart';

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
    final darkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: darkMode
          ? const Color.fromARGB(255, 58, 50, 83)
          : const Color.fromARGB(255, 234, 234, 234),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          "Quizz",
          style: TextStyle(
            color: Color.fromARGB(255, 98, 128, 182),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 98, 128, 182),
          ),
          onPressed: () {
            Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
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
          color: Colors.black,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 98, 128, 182),
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
              child: const Text(
                "Categories",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.05),
              child: Expanded(
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
                          color: Colors.white,
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
                                    radius: 30.0,
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    theme.title,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
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
            ),
          ],
        ),
      ),
    );
  }
}
