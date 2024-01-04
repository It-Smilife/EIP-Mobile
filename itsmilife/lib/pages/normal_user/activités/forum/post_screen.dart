import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itsmilife/pages/normal_user/activit%C3%A9s/forum/forum.dart';
import 'package:itsmilife/services/NetworkManager.dart';
import 'package:provider/provider.dart';
import 'package:itsmilife/pages/common/settings/darkModeProvider.dart';
import 'package:itsmilife/pages/common/settings/languageProvider.dart';
import 'package:itsmilife/pages/normal_user/activités/forum/models/post_model.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:itsmilife/pages/common/profile.dart';
import 'package:expandable_text/expandable_text.dart';

class PostScreen extends StatefulWidget {
  final String id;
  PostScreen({super.key, required this.id});
  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late Future<Post> postsFuture;
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  bool isUpdated = false;
  TextEditingController _comController = TextEditingController();
  bool isExpanded = false;

  String setLanguage() {
    final lang = Provider.of<LanguageProvider>(context);
    if (lang.lang == "English") {
      return 'en';
    }
    return 'fr';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _comController.dispose();
    super.dispose();
  }

  String convertDate(date) {
    DateTime dateConvert = DateTime.parse(date);
    timeago.setLocaleMessages('fr', timeago.FrMessages());
    final now = DateTime.now().toUtc();
    final difference = now.difference(dateConvert.toUtc());
    return timeago.format(now.subtract(difference), locale: setLanguage());
  }

  Future<Post> fetchPost() async {
    final response = await NetworkManager.get('forums/${widget.id}');
    if (response.data != "No forum found" && response.data['success'] == true) {
      Post post = Post.fromJson(response.data['message']);
      return post;
    } else {
      throw Exception();
    }
  }

  void deletePost(postId) {
    NetworkManager.delete('forums/${postId}').then(
      (value) => {
        if (value.data['success'] == true)
          {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => const Forum(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
            )
          }
      },
    );
  }

  void deleteComment(commentId) {
    NetworkManager.delete('comments/$commentId').then((value) {
      if (value.data['success'] == true) {
        if (mounted) {
          setState(() {
            postsFuture = fetchPost();
          });
        }
        Navigator.pop(context);
      }
    });
  }

  void addComment(content) {
    NetworkManager.post('commentsByForumId/${widget.id}', {
      "content": content,
      "user": ProfileData.id,
    }).then((value) {
      if (value.data['success'] == true) {
        print("comment well added");
        if (mounted) {
          setState(() {
            postsFuture = fetchPost();
          });
          _comController.clear();
        }
      } else {
        print(value.data);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    postsFuture = fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final darkMode = Provider.of<DarkModeProvider>(context);
    final FocusNode _focusNode = FocusNode();

    return Consumer2<LanguageProvider, DarkModeProvider>(builder: (context, lang, darkMode, _) {
      return FutureBuilder<Post>(
          future: postsFuture,
          builder: (BuildContext context, AsyncSnapshot<Post> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              final posts = snapshot.data! as Post;
              _titleController.text = posts.title;
              _contentController.text = posts.content;
              return Scaffold(
                backgroundColor: darkMode.darkMode ? const Color.fromARGB(255, 58, 50, 83) : Colors.grey[200],
                body: SafeArea(
                  child: ListView(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                        child: Row(
                          children: <Widget>[
                            IconButton(
                                color: darkMode.darkMode ? Colors.white : Colors.black,
                                onPressed: () => {
                                      dispose(),
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const Forum(),
                                        ),
                                      ),
                                    },
                                icon: const Icon(
                                  CupertinoIcons.back,
                                  size: 20,
                                  color: Colors.black,
                                )),
                            const SizedBox(width: 5.0),
                            Text(
                              "Post",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: darkMode.darkMode ? Colors.white : Colors.black),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15.0),
                        decoration: BoxDecoration(
                            color: darkMode.darkMode ? const Color.fromARGB(255, 45, 45, 45) : const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [BoxShadow(color: Colors.black26.withOpacity(0.05), offset: const Offset(0.0, 6.0), blurRadius: 10.0, spreadRadius: 0.10)]),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 60,
                                color: darkMode.darkMode ? const Color.fromARGB(255, 45, 45, 45) : const Color.fromARGB(255, 255, 255, 255),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        FutureBuilder<Uint8List>(
                                          future: NetworkManager.getFile(posts.user["avatar"]),
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
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                posts.user["username"],
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: .4,
                                                  color: darkMode.darkMode ? Colors.white : Colors.grey.withOpacity(0.6),
                                                ),
                                              ),
                                              const SizedBox(height: 2.0),
                                              Text(
                                                convertDate(posts.date),
                                                style: TextStyle(color: darkMode.darkMode ? Colors.white : Colors.grey.withOpacity(0.6)),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    if (posts.user["username"].toString() == ProfileData.id)
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(CupertinoIcons.pen),
                                            onPressed: () => {
                                              showDialog(
                                                context: context,
                                                builder: (context) => AlertDialog(
                                                  title: Text(lang.lang == "English" ? "Edit this post" : "Modifier ce post"),
                                                  actions: [
                                                    Form(
                                                      key: _formKey,
                                                      child: SizedBox(
                                                        width: MediaQuery.of(context).size.width * 0.90,
                                                        height: MediaQuery.of(context).size.height * 0.40,
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(10),
                                                          child: Column(
                                                            children: <Widget>[
                                                              TextFormField(
                                                                controller: _titleController,
                                                                decoration: InputDecoration(
                                                                  prefixIcon: const Icon(CupertinoIcons.pencil),
                                                                  hintText: _titleController.text,
                                                                ),
                                                                validator: (value) {
                                                                  if (value == null || value.isEmpty) {
                                                                    return lang.lang == "English" ? 'Please enter a title' : 'Veuillez entrer un titre';
                                                                  }
                                                                  return null;
                                                                },
                                                                maxLines: null,
                                                                textAlignVertical: TextAlignVertical.top,
                                                              ),
                                                              TextFormField(
                                                                controller: _contentController,
                                                                decoration: InputDecoration(
                                                                  prefixIcon: const Icon(CupertinoIcons.pencil),
                                                                  hintText: _contentController.text,
                                                                ),
                                                                validator: (value) {
                                                                  if (value == null || value.isEmpty) {
                                                                    return lang.lang == "English" ? 'Please enter a title' : 'Veuillez entrer un titre';
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                              Row(
                                                                children: [
                                                                  TextButton(
                                                                    onPressed: () => {Navigator.pop(context)},
                                                                    child: Text(
                                                                      lang.lang == "English" ? "Cancel" : "Annuler",
                                                                    ),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed: () {
                                                                      if (_formKey.currentState!.validate()) {
                                                                        NetworkManager.put(
                                                                          "forums/${posts.id}",
                                                                          {
                                                                            "title": _titleController.text,
                                                                            "content": _contentController.text,
                                                                            "date": DateTime.now(),
                                                                          },
                                                                        ).then((value) {
                                                                          if (value.data['success'] == true) {
                                                                            Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                builder: (_) => PostScreen(
                                                                                  id: widget.id,
                                                                                ),
                                                                              ),
                                                                            );
                                                                          }
                                                                        });
                                                                      }
                                                                    },
                                                                    child: Text(
                                                                      lang.lang == "English" ? "Save" : "Sauvegarder",
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            },
                                            color: darkMode.darkMode ? Colors.white : Colors.black,
                                          ),
                                          IconButton(
                                            icon: const Icon(CupertinoIcons.trash),
                                            onPressed: () => {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return Dialog(
                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                    child: Container(
                                                      constraints: const BoxConstraints(maxHeight: 200),
                                                      child: Padding(
                                                          padding: const EdgeInsets.only(top: 20, right: 20, left: 30),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Text(
                                                                lang.lang == "English" ? "Delete this post" : "Supprimer ce post",
                                                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                                              ),
                                                              const SizedBox(height: 10),
                                                              Text(
                                                                lang.lang == "English" ? "Are you sure that you want to delete this post ?" : "Êtes-vous sûr de vouloir supprimer ce post ?",
                                                                style: const TextStyle(
                                                                  fontSize: 17,
                                                                ),
                                                              ),
                                                              const SizedBox(height: 40),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                                                    onPressed: () => {deletePost(posts.id)},
                                                                    child: Text(
                                                                      lang.lang == "English" ? "yes" : "Oui",
                                                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(width: 20),
                                                                  ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                                                    onPressed: () => {Navigator.pop(context)},
                                                                    child: Text(
                                                                      lang.lang == "English" ? "Cancel" : "Anuler",
                                                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          )),
                                                    ),
                                                  );
                                                },
                                              ),
                                            },
                                            color: Colors.red,
                                          ),
                                        ],
                                      )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 15.0),
                                child: Text(
                                  posts.title,
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: darkMode.darkMode ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                posts.content,
                                style: TextStyle(color: darkMode.darkMode ? Colors.white : Colors.black, fontSize: 17, letterSpacing: .2),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    const SizedBox(width: 15.0),
                                    Row(
                                      children: <Widget>[
                                        const SizedBox(width: 4.0),
                                        Text(
                                          lang.lang == "English" ? "${posts.views} views" : "${posts.views} vues",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: darkMode.darkMode ? Colors.white : Colors.grey,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, top: 20.0, bottom: 10.0),
                        child: Text(
                          lang.lang == "English" ? "Comments (${posts.comments.length})" : "Commentaires (${posts.comments.length})",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: darkMode.darkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      Column(
                        children: posts.comments.reversed
                            .map(
                              (comment) => Container(
                                margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
                                decoration: BoxDecoration(
                                  color: darkMode.darkMode ? const Color.fromARGB(255, 45, 45, 45) : const Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [BoxShadow(color: Colors.black26.withOpacity(0.03), offset: const Offset(0.0, 6.0), blurRadius: 10.0, spreadRadius: 0.10)],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        height: 60,
                                        color: darkMode.darkMode ? const Color.fromARGB(255, 45, 45, 45) : const Color.fromARGB(255, 255, 255, 255),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                FutureBuilder<Uint8List>(
                                                  future: NetworkManager.getFile(posts.user["avatar"]),
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
                                                  padding: const EdgeInsets.only(left: 8.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Text(
                                                        comment.user['username'],
                                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: .4, color: darkMode.darkMode ? Colors.white : Colors.black),
                                                      ),
                                                      const SizedBox(height: 2.0),
                                                      Text(
                                                        convertDate(comment.date),
                                                        style: TextStyle(color: darkMode.darkMode ? Colors.white : Colors.grey),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            IconButton(
                                              icon: const Icon(CupertinoIcons.trash),
                                              onPressed: () => {
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return Dialog(
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                      child: Container(
                                                        constraints: const BoxConstraints(maxHeight: 200),
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(top: 20, right: 20, left: 30),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Text(
                                                                lang.lang == "English" ? "Delete this comment" : "Supprimer ce commentaire",
                                                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                                              ),
                                                              const SizedBox(height: 10),
                                                              Text(
                                                                lang.lang == "English" ? "Are you sure that you want to delete this comment ?" : "Êtes-vous sûr de vouloir supprimer ce commentaire ?",
                                                                style: const TextStyle(
                                                                  fontSize: 17,
                                                                ),
                                                              ),
                                                              const SizedBox(height: 40),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                                                    onPressed: () => {deleteComment(comment.id)},
                                                                    child: Text(
                                                                      lang.lang == "English" ? "yes" : "Oui",
                                                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(width: 20),
                                                                  ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                                                    onPressed: () => {Navigator.pop(context)},
                                                                    child: Text(
                                                                      lang.lang == "English" ? "Cancel" : "Anuler",
                                                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              },
                                              color: Colors.red,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                                        child: ExpandableText(
                                          comment.content,
                                          animation: true,
                                          maxLines: 4,
                                          collapseOnTextTap: true,
                                          expandText: lang.lang == "English" ? "see more" : "voir plus",
                                          collapseText: lang.lang == "English" ? "see less" : "voir moins",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 15.0),
                    ],
                  ),
                ),
                bottomNavigationBar: SafeArea(
                  child: AnimatedContainer(
                    duration: const Duration(microseconds: 1),
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 8.0, left: 20.0, right: 8.0),
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _comController,
                            focusNode: _focusNode,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: 'Ajouter un commentaire...',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(40.0), borderSide: BorderSide.none),
                              hintStyle: TextStyle(color: darkMode.darkMode ? Colors.white : Colors.black),
                              filled: true, // Add this line
                              fillColor: darkMode.darkMode ? const Color.fromARGB(255, 45, 45, 45) : Colors.white, // Add this line
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.send_rounded,
                            color: darkMode.darkMode ? Colors.white : Colors.black,
                          ),
                          onPressed: () {
                            addComment(_comController.text);
                            _focusNode.unfocus();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return (const Center(
                child: Text("No data"),
              ));
            }
          });
    });
  }
}
