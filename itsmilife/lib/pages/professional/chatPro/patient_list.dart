import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itsmilife/pages/common/chat/model/chatMessageModel.dart';
import 'package:itsmilife/pages/common/profile.dart';
import 'package:itsmilife/pages/normal_user/chat/AddPro.dart';
import 'package:itsmilife/pages/professional/homepro.dart';
import 'package:itsmilife/services/NetworkManager.dart';
import 'package:intl/intl.dart';
import '../../../widgets/conversationList.dart';
import '../../normal_user/chat/model/chatUsersModel.dart';
import 'notificationCenter.dart';

class ListPatient extends StatefulWidget {
  const ListPatient({super.key});

  @override
  _ListPatientState createState() => _ListPatientState();
}

class _ListPatientState extends State<ListPatient> {
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
          String date = val.data['message'][i]['date'];
          DateTime dateTime = DateTime.parse(date);
          dateTime = dateTime.toLocal();
          String formattedDate = DateFormat('jm').format(dateTime);
          ChatUsers discussion = new ChatUsers(
              ID: val.data['message'][i]['_id'],
              patientID: val.data['message'][i]['patient']['_id'],
              proID: val.data['message'][i]['professional']['_id'],
              imageURL: "test/img",
              name: val.data['message'][i]['professional']['username'],
              time: formattedDate,
              LastMessage: (val.data['message'][i]['messages'] != null &&
                      val.data['message'][i]['messages'].isNotEmpty)
                  ? val.data['message'][i]['messages']
                      [val.data['message'][i]['messages'].length - 1]
                  : "Démarrez la conversation !");
          chatUsers.add(discussion);
        }
        return chatUsers;
      } else {
        throw Exception('Failed to load chat users');
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    List<ContactRequest> requests = [
  ContactRequest(
    username: 'John Doe',
    avatarUrl: 'assets/avatarpro.png',
  ),
  ContactRequest(
    username: 'Jane Smith',
    avatarUrl: 'assets/avatarpro.png',
  ),
];
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
                      child: Icon(Icons.arrow_back, color: Colors.black),
                      onTap: () {
                        Navigator.pop(context);
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
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color.fromARGB(255, 218, 24, 24),
                      ),
                      child: InkWell(
                            child: Icon(
                            Icons.notifications,
                            color: Color.fromARGB(255, 255, 255, 255),
                            size: 25,
                          ),
                            onTap: (() {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      NotificationPage(requests: requests),
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
