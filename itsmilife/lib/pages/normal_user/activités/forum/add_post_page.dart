import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itsmilife/services/NetworkManager.dart';
import 'package:itsmilife/pages/common/profile.dart';
import 'package:provider/provider.dart';
import 'package:itsmilife/pages/common/settings/darkModeProvider.dart';
import 'package:itsmilife/pages/common/settings/languageProvider.dart';

// class AddPostPage extends StatefulWidget {
//   const AddPostPage({super.key});

//   @override
//   State<AddPostPage> createState() => _AddPost();
// }

// class _AddPost extends State<AddPostPage> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             icon: const Icon(CupertinoIcons.back),
//             color: Colors.black,
//             onPressed: () => {
//               Navigator.pop(context)
//             },
//           ),
//           backgroundColor: Colors.transparent,
//           shadowColor: Colors.transparent,
//         ),
//         body: const SingleChildScrollView(

//         ),
//       ),
//     );
//   }
// }

class AddPostForm extends StatefulWidget {
  const AddPostForm({super.key});

  @override
  _AddPostFormState createState() => _AddPostFormState();
}

class _AddPostFormState extends State<AddPostForm> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _content = '';
  List<String> _tags = [];
  final FocusNode _focusNode = FocusNode();

  void test() {
    print(ProfileData.id);
    print(ProfileData.email);
  }

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
        Navigator.pop(context);
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
                          : 'Entrez un titre svp';
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
                    border: const OutlineInputBorder(),
                    // contentPadding: EdgeInsets.symmetric(vertical: 60, horizontal: 10)
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some content';
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
                ElevatedButton(
                  onPressed: () {
                    test();
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      addPost(_title, _content);
                    }
                  },
                  child: Text(lang.lang == "English" ? 'Submit' : 'Envoyer'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
