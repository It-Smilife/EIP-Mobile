import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itsmilife/pages/common/profile.dart';
import 'package:itsmilife/pages/normal_user/activit%C3%A9s/forum/post_screen_user.dart';
import 'package:itsmilife/services/NetworkManager.dart';
import 'package:provider/provider.dart';
import 'package:itsmilife/pages/normal_user/activités/forum/models/post_model.dart';
import 'package:itsmilife/pages/common/settings/darkModeProvider.dart';
import 'package:itsmilife/pages/common/settings/languageProvider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:shimmer/shimmer.dart';

class UserPosts extends StatefulWidget {
  const UserPosts({super.key});

  @override
  State<UserPosts> createState() => _UserPosts();
}

class _UserPosts extends State<UserPosts> {
  late Future<List<Post>> postsFuture;

  @override
  void initState() {
    super.initState();
    postsFuture = NetworkManager.get('userForums/${ProfileData.id}').then((value) {
      if (value.data != "No forums found" && value.data['success'] == true) {
        List<Post> posts = [];
        for (int i = 0; i != value.data['message'].length; i++) {
          posts.add(Post.fromJson(value.data['message'][i]));
        }
        return posts;
      } else {
        throw Exception();
      }
    });
  }

  String setLanguage() {
    final lang = Provider.of<LanguageProvider>(context);
    if (lang.lang == "English") {
      return 'en';
    }
    timeago.setLocaleMessages('fr', timeago.FrMessages());
    return 'fr';
  }

  String convertDate(date) {
    DateTime dateConvert = DateTime.parse(date);
    timeago.setLocaleMessages('fr', timeago.FrMessages());
    final now = DateTime.now().toUtc();
    final difference = now.difference(dateConvert.toUtc());
    return timeago.format(now.subtract(difference), locale: setLanguage());
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final darkMode = Provider.of<DarkModeProvider>(context);

    return FutureBuilder<List<Post>>(
        future: Future.delayed(const Duration(seconds: 2), () => postsFuture),
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: 180,
                margin: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: darkMode.darkMode ? const Color.fromARGB(255, 45, 45, 45) : const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [BoxShadow(color: Colors.black26.withOpacity(0.05), offset: const Offset(0.0, 6.0), blurRadius: 10.0, spreadRadius: 0.10)],
                ),
              ),
            );
          }
          if (snapshot.hasData) {
            final posts = snapshot.data! as List<Post>;
            if (posts.length == 0) {
              return Container();
            }
            return Column(
                children: posts.reversed
                    .map(
                      (post) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PostScreenUser(
                                id: post.id,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                              color: darkMode.darkMode ? Color.fromARGB(255, 45, 45, 45) : Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [BoxShadow(color: Colors.black26.withOpacity(0.3), offset: const Offset(0.0, 6.0), blurRadius: 10.0, spreadRadius: 0.10)]),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: IntrinsicHeight(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  SizedBox(
                                    height: 70,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            FutureBuilder<Uint8List>(
                                              future: NetworkManager.getFile(post.user["avatar"]),
                                              builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
                                                if (snapshot.connectionState == ConnectionState.waiting) {
                                                  // loading
                                                  return const CircularProgressIndicator();
                                                } else if (snapshot.hasError) {
                                                  // error
                                                  return Text('Erreur : ${snapshot.error}');
                                                } else if (snapshot.hasData) {
                                                  // success
                                                  return CircleAvatar(
                                                    backgroundImage: MemoryImage(snapshot.data ?? Uint8List(0)),
                                                    radius: 30,
                                                  );
                                                } else {
                                                  // default
                                                  return const CircleAvatar(
                                                    backgroundColor: Colors.grey, // Couleur de fond
                                                    radius: 30,
                                                  );
                                                }
                                              },
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 5.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: MediaQuery.of(context).size.width * 0.65,
                                                    child: Text(
                                                      post.title.length <= 50 ? post.title : post.title.substring(0, 50) + '...',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                        letterSpacing: .4,
                                                        color: darkMode.darkMode ? Colors.white : Color.fromARGB(255, 75, 75, 75),
                                                      ),
                                                      overflow: TextOverflow.ellipsis, // Ajoute la suspension (...) en cas de dépassement.
                                                    ),
                                                  ),
                                                  const SizedBox(height: 2.0),
                                                  Row(
                                                    children: <Widget>[
                                                      Text(
                                                        lang.lang == "English" ? "You" : "Vous",
                                                        style: TextStyle(color: darkMode.darkMode ? Colors.white : Color.fromARGB(255, 75, 75, 75)),
                                                      ),
                                                      const SizedBox(width: 15),
                                                      Text(
                                                        convertDate(post.date),
                                                        style: TextStyle(color: darkMode.darkMode ? Colors.white : Color.fromARGB(255, 75, 75, 75)),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        "${post.content.length > 50 ? post.content.substring(0, 50) : post.content}..",
                                        style: TextStyle(color: darkMode.darkMode ? Colors.white : Color.fromARGB(255, 75, 75, 75), fontSize: 16, letterSpacing: .3),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            CupertinoIcons.mail,
                                            color: darkMode.darkMode ? Colors.white : const Color.fromARGB(255, 108, 108, 108),
                                            size: 16,
                                          ),
                                          const SizedBox(width: 4.0),
                                          Text(
                                            lang.lang == "English" ? "${post.replies_count} replies" : "${post.replies_count} réponses",
                                            style: TextStyle(fontSize: 14, color: darkMode.darkMode ? Colors.white : const Color.fromARGB(255, 108, 108, 108)),
                                          )
                                        ],
                                      ),
                                      // Row(
                                      //   children: <Widget>[
                                      //     Icon(
                                      //       CupertinoIcons.eye,
                                      //       color: darkMode.darkMode ? Colors.white : Colors.grey.withOpacity(0.6),
                                      //       size: 18,
                                      //     ),
                                      //     const SizedBox(width: 4.0),
                                      //     Text(
                                      //       lang.lang == "English" ? "${post.views} views" : "${post.views} vues",
                                      //       style: TextStyle(fontSize: 14, color: darkMode.darkMode ? Colors.white : Colors.grey.withOpacity(0.6)),
                                      //     )
                                      //   ],
                                      // )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList());
          } else {
            return Center(
                child: Column(children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey, // Couleur de l'ombre
                      offset: Offset(0, 3), // Décalage de l'ombre par rapport au conteneur
                      blurRadius: 5, // Rayon du flou de l'ombre
                      spreadRadius: 0, // L'étendue de l'ombre
                    ),
                  ],
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Icon(CupertinoIcons.clear_thick_circled, size: 55, color: Colors.red),
                      SizedBox(
                        height: 30,
                      ),
                      Text("Aucun post trouvé", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ]));
          }
        });
  }
}
