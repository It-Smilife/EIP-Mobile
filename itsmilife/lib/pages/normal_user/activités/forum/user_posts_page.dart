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
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';

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
      backgroundColor: const Color.fromARGB(255, 98, 128, 182),
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
              decoration: const BoxDecoration(color: Color.fromARGB(255, 98, 128, 182)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      lang.lang == "English" ? "Welcome to the forum !" : "Bienvenue sur le forum !",
                      style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          lang.lang == "English" ? "You will find here several testimonials" : "Tu trouveras ici plusieurs témoignage",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 14.0,
                          ),
                        ),
                        const Icon(
                          CupertinoIcons.search,
                          size: 20,
                          color: Colors.white,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(35.0), topRight: Radius.circular(35.0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //TopBar(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      lang.lang == "English" ? "Mes posts" : "My posts",
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 20.0, bottom: 10.0),
                    child: Text(
                      lang.lang == "English" ? "Most popular posts" : "Posts les plus populairs",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
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
