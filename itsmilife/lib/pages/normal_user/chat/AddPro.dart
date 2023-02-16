import 'package:flutter/material.dart';
import 'package:itsmilife/pages/common/chat/model/chatMessageModel.dart';
import 'package:itsmilife/services/NetworkManager.dart';

import '../../../widgets/AddListpro.dart';
import '../../../widgets/conversationList.dart';
import 'model/chatUsersModel.dart';

class AddPro extends StatefulWidget {
  const AddPro({super.key});

  @override
  _AddProState createState() => _AddProState();
}

class _AddProState extends State<AddPro> {
  late Future<List<UserPro>> _UsersProFuture;

  @override
  void initState() {
    super.initState();
    _UsersProFuture = NetworkManager.get("professionals").then((val) {
      if (val.data['success'] == true) {
        List<UserPro> chatUsers = [];
        for (int i = 0; i != val.data['message'].length; i++) {
          UserPro user = new UserPro(
              id: val.data['message'][i]['_id'],
              username: val.data['message'][i]['username'],
              imgURL: "test/img");
          chatUsers.add(user);
        }
        return chatUsers;
      } else {
        throw Exception('Failed to load chat users');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 16, right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: const EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                ),
              ),
            ),
            FutureBuilder<List<UserPro>>(
              future: _UsersProFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 16),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return AddProList(
                        username: snapshot.data![index].username,
                        id: snapshot.data![index].id,
                        imgURL: "test/img",
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // By default, show a loading spinner.
                return CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}

