import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itsmilife/services/NetworkManager.dart';
import 'package:provider/provider.dart';
import 'package:itsmilife/pages/normal_user/activités/forum/models/post_model.dart';
import 'package:itsmilife/pages/normal_user/activités/forum/post_screen.dart';
import 'package:itsmilife/pages/common/settings/darkModeProvider.dart';
import 'package:itsmilife/pages/common/settings/languageProvider.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _Posts();
}

class _Posts extends State<Posts> {
  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  /* void fetchPosts() async {
    // try {
    http.Response response =
        await http.get(Uri.parse('http://51.145.251.116:80/forums'));
    // print("REPONSE" + json.decode(response.body)['message']);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response,
      // parse the JSON response and add each post to the 'posts' list
      List jsonPosts = json.decode(response.body)['message'];
      setState(() {
        //posts = jsonPosts;
      });
    }
    // } catch (error) {
    //   print(error.toString());
    // }
    print("FDPPPPP\n $posts");
  }*/

  void fetchPosts() async {
    http.Response response = await http
        .get(Uri.parse('http://51.145.251.116:80/forums'))
        .then((value) => value);

    List<dynamic> jsonPosts = json.decode(response.body)['message'];
    for (var jsonPost in jsonPosts) {
      setState(() {
        posts.add(Post.fromJson(jsonPost));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final darkMode = Provider.of<DarkModeProvider>(context);
    return Column(
        children: posts
            .map(
              (post) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PostScreen(
                        question: post,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 180,
                  margin: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26.withOpacity(0.05),
                            offset: const Offset(0.0, 6.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.10)
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
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
                                  const CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/images/author1.jpg'),
                                    radius: 22,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.65,
                                          child: Text(
                                            post.title,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: .4),
                                          ),
                                        ),
                                        const SizedBox(height: 2.0),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              "username",
                                              style: TextStyle(
                                                  color: Colors.grey
                                                      .withOpacity(0.6)),
                                            ),
                                            const SizedBox(width: 15),
                                            Text(
                                              post.date,
                                              style: TextStyle(
                                                  color: Colors.grey
                                                      .withOpacity(0.6)),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                CupertinoIcons.bookmark,
                                color: Colors.grey.withOpacity(0.6),
                                size: 26,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          child: Center(
                            child: Text(
                              /*"${post.content.substring(0, 80)}.."*/ "content",
                              style: TextStyle(
                                  color: Colors.grey.withOpacity(0.8),
                                  fontSize: 16,
                                  letterSpacing: .3),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  CupertinoIcons.hand_thumbsup,
                                  color: Colors.grey.withOpacity(0.6),
                                  size: 22,
                                ),
                                const SizedBox(width: 4.0),
                                // Text(
                                //   "${question.votes} votes",
                                //   style: TextStyle(
                                //       fontSize: 14,
                                //       color: Colors.grey.withOpacity(0.6),
                                //       fontWeight: FontWeight.w600),
                                // )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  CupertinoIcons.mail,
                                  color: Colors.grey.withOpacity(0.6),
                                  size: 16,
                                ),
                                const SizedBox(width: 4.0),
                                Text(
                                  lang.lang == "English"
                                      ? "${post.replies_count} replies"
                                      : "${post.replies_count} réponses",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.withOpacity(0.6)),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  CupertinoIcons.eye,
                                  color: Colors.grey.withOpacity(0.6),
                                  size: 18,
                                ),
                                const SizedBox(width: 4.0),
                                Text(
                                  lang.lang == "English"
                                      ? "${post.views} views"
                                      : "${post.views} vues",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.withOpacity(0.6)),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
            .toList());
  }
}
