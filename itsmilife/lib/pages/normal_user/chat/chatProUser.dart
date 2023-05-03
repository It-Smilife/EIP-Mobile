import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itsmilife/pages/common/chat/model/chatMessageModel.dart';
import 'package:itsmilife/pages/common/profile.dart';
import 'package:itsmilife/pages/normal_user/chat/AddPro.dart';
import 'package:itsmilife/services/NetworkManager.dart';
import 'package:intl/intl.dart';
import 'package:itsmilife/widgets/bottomNavBar.dart';
import '../../../widgets/conversationList.dart';
import '../homepage/homepage.dart';
import 'model/chatUsersModel.dart';

class ChatProUser extends StatefulWidget {
  const ChatProUser({super.key});

  @override
  _ChatProUserState createState() => _ChatProUserState();
}

class _ChatProUserState extends State<ChatProUser> {
  late Future<List<ChatUsers>> _chatUsersFuture;

  @override
  void initState() {
    super.initState();
    _chatUsersFuture =
        NetworkManager.get("users/" + ProfileData.id + "/discussions")
            .then((val) {
      if (val.data['success'] == true) {
        List<ChatUsers> chatUsers = [];
        for (int i = 0; i != val.data['message'].length; i++) {
          if (val.data['message'][i]['professional']['_id'] != ProfileData.id) {
            String date = val.data['message'][i]['date'];
            DateTime dateTime = DateTime.parse(date);
            dateTime = dateTime.toLocal();
            String formattedDate = DateFormat('jm').format(dateTime);
            ChatUsers discussion = new ChatUsers(
                ID: val.data['message'][i]['_id'],
                patientID: val.data['message'][i]['patient']['_id'],
                proID: val.data['message'][i]['professional']['_id'],
                imageURL: val.data['message'][i]['professional']['avatar'],
                name: val.data['message'][i]['professional']['username'],
                time: formattedDate,
                LastMessage: (val.data['message'][i]['messages'] != null &&
                        val.data['message'][i]['messages'].isNotEmpty)
                    ? val.data['message'][i]['messages']
                        [val.data['message'][i]['messages'].length - 1]['content']
                    : "Démarrez la conversation !");
            chatUsers.add(discussion);
          }
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
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      child: Icon(Icons.arrow_back),
                      onTap: () {
                        Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  Home(h_index: 1),
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
                      },
                    ),
                    const Text(
                      "Conversations",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 2, bottom: 2),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color.fromARGB(255, 98, 128, 182),
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.add,
                            color: Color.fromARGB(255, 255, 255, 255),
                            size: 20,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          InkWell(
                            child: Text(
                              "Add New",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            onTap: (() {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const AddPro(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(1, 0),
                                        end: Offset.zero,
                                      ).animate(animation),
                                      child: child,
                                    );
                                  },
                                  transitionDuration:
                                      const Duration(milliseconds: 300),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
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
            FutureBuilder<List<ChatUsers>>(
              future: _chatUsersFuture,
              builder: (BuildContext context,
                  AsyncSnapshot<List<ChatUsers>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData) {
                  final chatUsers = snapshot.data!;
                  return ListView.builder(
                    itemCount: chatUsers.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 16),
                    itemBuilder: (context, index) {
                      final discussion = chatUsers[index];
                      return Dismissible(
                          key: Key(discussion.ID),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            child: const Icon(
                              CupertinoIcons.delete,
                              color: Colors.white,
                            ),
                          ),
                          onDismissed: (direction) {
                            // Supprime l'élément de la liste
                            setState(() {
                              NetworkManager.delete(
                                      "discussions/" + discussion.ID)
                                  .then((val) {
                                if (val.data['success'] == true) {
                                  print("discussion supprimer");
                                } else {
                                  throw Exception(
                                      'Failed to delete discussion');
                                }
                              });
                              chatUsers.removeAt(index);
                            });
                            // Affiche un message d'information
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Conversation supprimée")),
                            );
                          },
                          child: ConversationList(
                            discussion_id: chatUsers[index].ID,
                            name: chatUsers[index].name,
                            messageText: chatUsers[index].LastMessage,
                            imageUrl: chatUsers[index].imageURL,
                            time: chatUsers[index].time,
                            isMessageRead:
                                (index == 0 || index == 3) ? true : false,
                          ));
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return Center(child: Text('No data'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
