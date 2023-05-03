import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itsmilife/pages/common/profile.dart';
import 'package:itsmilife/pages/common/settings/package_settings/babs_component_settings_item.dart';
import 'package:itsmilife/pages/common/settings/package_settings/icon_style.dart';
import 'package:itsmilife/pages/normal_user/activit%C3%A9s/forum/models/post_model.dart';
import 'package:itsmilife/pages/normal_user/activit%C3%A9s/forum/user_posts_page.dart';
import 'package:itsmilife/pages/normal_user/activités/forum/widgets/posts.dart';
import 'package:itsmilife/widgets/bottomNavBar.dart';
import 'package:provider/provider.dart';
import 'package:itsmilife/pages/common/settings/darkModeProvider.dart';
import 'package:itsmilife/pages/common/settings/languageProvider.dart';
import 'package:itsmilife/pages/normal_user/activités/forum/add_post_page.dart';
import 'package:itsmilife/pages/common/settings/package_settings/babs_component_big_user_card.dart';

class Forum extends StatefulWidget {
  const Forum({super.key});

  @override
  State<Forum> createState() => _Forum();
}

class _Forum extends State<Forum> {
  void checkQuestions(List<Post> questions) {
    questions.forEach((question) {
      // print("------------------------");
      // print(question.author.name);
      // print(question.question);
      // print(question.content);
      // print(question.views);
      // print(question.votes);
      // print(question.replies);
      // Afficher les autres propriétés de l'objet Question
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final darkMode = Provider.of<DarkModeProvider>(context);
    return Scaffold(
      backgroundColor: darkMode.darkMode ? const Color.fromARGB(255, 32, 32, 32) : const Color.fromARGB(255, 98, 128, 182),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Home(h_index: 0),
              ),
            );
          },
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              height: 120,
              width: MediaQuery.of(context).size.width,
              decoration:
                  BoxDecoration(color: darkMode.darkMode ? const Color.fromARGB(255, 32, 32, 32) : const Color.fromARGB(255, 98, 128, 182)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      lang.lang == "English"
                          ? "Welcome to the forum !"
                          : "Bienvenue sur le forum !",
                      style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          lang.lang == "English"
                              ? "You will find here several testimonials"
                              : "Tu trouveras ici plusieurs témoignage",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: darkMode.darkMode ? const Color.fromARGB(255, 58, 50, 83) : Color.fromARGB(255, 218, 218, 218),
                  borderRadius:BorderRadius.all(Radius.circular(35))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: BigUserCard(
                      backgroundColor: const Color.fromARGB(255, 98, 128, 182),
                      userName: ProfileData.username == ""
                          ? "Default name"
                          : ProfileData.username,
                      userProfilePic: const AssetImage("assets/logo.png"),
                      cardActionWidget: SettingsItem(
                        icons: Icons.edit,
                        iconStyle: IconStyle(
                          withBackground: true,
                          borderRadius: 50,
                          backgroundColor: Colors.purple,
                        ),
                        title: lang.lang == "English"
                            ? "See my posts"
                            : "Voir mes posts",
                        subtitle: lang.lang == "English"
                            ? "Tap to see your posts"
                            : "Cliquez pour voir vos posts",
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const UserPostsPage(),
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
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 20.0, bottom: 10.0),
                    child: Text(
                      lang.lang == "English"
                          ? "Most popular posts"
                          : "Posts les plus populairs",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: darkMode.darkMode ?Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  const Posts(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 98, 128, 182),
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddPostForm(),
            ),
          ),
        },
        child: const Icon(CupertinoIcons.pen),
      ),
    );
  }
}
