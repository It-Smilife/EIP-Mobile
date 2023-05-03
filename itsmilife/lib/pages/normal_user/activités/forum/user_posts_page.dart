import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itsmilife/pages/common/profile.dart';
import 'package:itsmilife/pages/normal_user/activit%C3%A9s/forum/forum.dart';
import 'package:itsmilife/pages/normal_user/activit%C3%A9s/forum/models/post_model.dart';
import 'package:itsmilife/pages/normal_user/activit%C3%A9s/forum/widgets/post_user.dart';
import 'package:itsmilife/pages/normal_user/activités/forum/widgets/popular_topics.dart';
import 'package:itsmilife/pages/normal_user/activités/forum/widgets/posts.dart';
import 'package:provider/provider.dart';
//import 'package:itsmilife/pages/normal_user/activités/forum/widgets/top_bar.dart';
import 'package:itsmilife/pages/normal_user/activités/activités.dart';
import 'package:itsmilife/pages/common/settings/darkModeProvider.dart';
import 'package:itsmilife/pages/common/settings/languageProvider.dart';
import 'package:itsmilife/pages/normal_user/activités/forum/add_post_page.dart';
// import 'package:itsmilife/pages/normal_user/activités/forum/test.dart';

class UserPostsPage extends StatefulWidget {
  const UserPostsPage({super.key});

  @override
  State<UserPostsPage> createState() => _UserPostsPage();
}

class _UserPostsPage extends State<UserPostsPage> {
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
                builder: (_) => Forum(),
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
              decoration: BoxDecoration(               
                color: darkMode.darkMode ? const Color.fromARGB(255, 32, 32, 32) : const Color.fromARGB(255, 98, 128, 182),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      lang.lang == "English"
                          ? "Welcome on your posts page !"
                          : "Bienvenue sur votre page de posts !",
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
                              ? "You will find here all your posts"
                              : "Tu trouveras ici tout tes posts",
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
                  color: darkMode.darkMode ? const Color.fromARGB(255, 58, 50, 83) : const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.all(Radius.circular(35))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //TopBar(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      lang.lang == "English" ? "Mes posts" : "My posts",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: darkMode.darkMode ?Colors.white : Colors.black),
                    ),
                  ),
                  const UserPosts(),
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
