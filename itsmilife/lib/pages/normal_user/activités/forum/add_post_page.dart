import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          color: Colors.black,
          icon: const Icon(CupertinoIcons.clear),
          onPressed: () => {Navigator.pop(context)},
        ),
        title: const Text(
          'Add a Post',
          style: TextStyle(
            color: Colors.black
          ),
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
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a title';
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
                  decoration: const InputDecoration(
                    labelText: 'Content',
                    border: OutlineInputBorder(),
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
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // TODO: Implement post submission logic here
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
