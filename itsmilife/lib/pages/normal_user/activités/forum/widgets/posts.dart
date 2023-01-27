import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final darkMode = Provider.of<DarkModeProvider>(context);
    return Column(
        children: questions
            .map(
              (question) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PostScreen(
                        question: question,
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
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage(question.author.imageUrl),
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
                                            question.question,
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
                                              question.author.name,
                                              style: TextStyle(
                                                  color: Colors.grey
                                                      .withOpacity(0.6)),
                                            ),
                                            const SizedBox(width: 15),
                                            Text(
                                              question.createdAt,
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
                              "${question.content.substring(0, 80)}..",
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
                                Text(
                                  "${question.votes} votes",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.withOpacity(0.6),
                                      fontWeight: FontWeight.w600),
                                )
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
                                      ? "${question.repliesCount} replies"
                                      : "${question.repliesCount} réponses",
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
                                      ? "${question.views} views"
                                      : "${question.views} vues",
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
