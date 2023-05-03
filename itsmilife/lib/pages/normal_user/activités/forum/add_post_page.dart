import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itsmilife/pages/normal_user/activit%C3%A9s/forum/forum.dart';
import 'package:itsmilife/services/NetworkManager.dart';
import 'package:itsmilife/pages/common/profile.dart';
import 'package:provider/provider.dart';
import 'package:itsmilife/pages/common/settings/darkModeProvider.dart';
import 'package:itsmilife/pages/common/settings/languageProvider.dart';

class AddPostForm extends StatefulWidget {
  const AddPostForm({super.key});

  @override
  _AddPostFormState createState() => _AddPostFormState();
}

class _AddPostFormState extends State<AddPostForm> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _content = '';
  final FocusNode _focusNode = FocusNode();

  void addPost(title, content) {
    NetworkManager.post('forums', {
      "title": title,
      "user": ProfileData.id,
      "comments": "63dcd7de4e73c3aec886af44",
      "content": content,
      "likes_count": 0,
      "replies_count": 0,
      "views": 0,
    }).then((value) {
      if (value.data['success'] == true) {
        print("ok for adding post");
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => Forum(),
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
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
      } else {
        print(value.data);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          color: Colors.black,
          icon: const Icon(CupertinoIcons.clear),
          onPressed: () => {Navigator.pop(context)},
        ),
        title: Text(
          lang.lang == "English" ? 'Add a Post' : 'Ajouter un Post',
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  focusNode: _focusNode,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: lang.lang == "English" ? 'Title' : 'Titre',
                    // border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return lang.lang == "English"
                          ? 'Please enter a title'
                          : 'Entrez un titre';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _title = value!;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    // labelText: lang.lang == "English" ? 'Write something...' : 'Ecrivez quelque chose...',
                    hintText: lang.lang == "English"
                        ? 'Write something...'
                        : 'Ecrivez quelque chose...',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    // contentPadding: EdgeInsets.symmetric(vertical: 60, horizontal: 10)
                  ),
                  maxLines: 10,
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez ecrire quelque chose';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _content = value!;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          addPost(_title, _content);
                        }
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 98, 128, 182))
                      ),
                      child:
                          Text(lang.lang == "English" ? 'Submit' : 'Envoyer'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
