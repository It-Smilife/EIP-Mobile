import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:itsmilife/pages/normal_user/activit%C3%A9s/forum/forum.dart';
import 'package:itsmilife/pages/normal_user/activit%C3%A9s/forum/models/replies_model.dart';
import 'package:itsmilife/pages/normal_user/activit%C3%A9s/forum/widgets/post_user.dart';
import 'package:itsmilife/pages/normal_user/activit%C3%A9s/forum/widgets/posts.dart';
import 'package:itsmilife/services/NetworkManager.dart';
import 'package:provider/provider.dart';
import 'package:itsmilife/pages/common/settings/darkModeProvider.dart';
import 'package:itsmilife/pages/common/settings/languageProvider.dart';
import 'package:itsmilife/pages/normal_user/activités/forum/models/post_model.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:itsmilife/pages/common/profile.dart';

class PostScreen extends StatefulWidget {
  String id;
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
                pageBuilder: (context, animation, secondaryAnimation) => Forum(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  );
                },
                transitionDuration: Duration(milliseconds: 300),
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
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              final posts = snapshot.data! as Post;
              _titleController.text = posts.title;
              _contentController.text = posts.content;
              if (posts == null) {
                return Container();
              }
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
                                          builder: (_) => Forum(),
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
                            color: darkMode.darkMode ? Color.fromARGB(255, 45, 45, 45) : const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [BoxShadow(color: Colors.black26.withOpacity(0.05), offset: const Offset(0.0, 6.0), blurRadius: 10.0, spreadRadius: 0.10)]),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 60,
                                color: darkMode.darkMode ? Color.fromARGB(255, 45, 45, 45) : const Color.fromARGB(255, 255, 255, 255),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        const CircleAvatar(
                                          backgroundImage: AssetImage('assets/images/author1.jpg'),
                                          radius: 22,
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
                                    if (posts.user["_id"].toString() == ProfileData.id)
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(CupertinoIcons.pen),
                                            onPressed: () => {
                                              showDialog(
                                                context: context,
                                                builder: (context) => AlertDialog(
                                                  title: Text("Modifier ce post"),
                                                  actions: [
                                                    Form(
                                                      key: _formKey,
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width * 0.90,
                                                        height: MediaQuery.of(context).size.height * 0.40,
                                                        child: Padding(
                                                          padding: EdgeInsets.all(10),
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
                                            icon: Icon(CupertinoIcons.trash),
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
                                        Icon(
                                          CupertinoIcons.eye,
                                          color: darkMode.darkMode ? Colors.white : Colors.grey,
                                          size: 18,
                                        ),
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
                                  color: darkMode.darkMode ? Color.fromARGB(255, 45, 45, 45) : const Color.fromARGB(255, 255, 255, 255),
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
                                        color: darkMode.darkMode ? Color.fromARGB(255, 45, 45, 45) : const Color.fromARGB(255, 255, 255, 255),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                CircleAvatar(
                                                  backgroundImage: AssetImage('assets/images/default_avatar.png'), // Replace with a default image path
                                                  radius: 18,
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
                                              icon: Icon(CupertinoIcons.trash),
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
                                        child: Text(
                                          comment.content,
                                          style: TextStyle(
                                            color: darkMode.darkMode ? Colors.white : Colors.black.withOpacity(0.25),
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      )
                    ],
                  ),
                ),
                bottomNavigationBar: SafeArea(
                  // Déplacez le SafeArea à l'intérieur du Scaffold
                  child: AnimatedContainer(
                    duration: Duration(microseconds: 100),
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 8.0, left: 20.0, right: 8.0),
                    color: darkMode.darkMode ? Color.fromARGB(255, 71, 71, 71) : Colors.grey[200],
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _comController,
                            focusNode: _focusNode,
                            decoration: InputDecoration(
                              hintText: 'Ajouter un commentaire...',
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: darkMode.darkMode ? Colors.white : Colors.grey[200]),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.send_rounded,
                            color: darkMode.darkMode ? Colors.white : Colors.grey[200],
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
              return (Center(
                child: Text("No data"),
              ));
            }
          });
    });
  }
}
