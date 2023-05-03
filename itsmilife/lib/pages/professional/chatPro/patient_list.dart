import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itsmilife/pages/common/chat/model/chatMessageModel.dart';
import 'package:itsmilife/pages/common/profile.dart';
import 'package:itsmilife/pages/normal_user/chat/AddPro.dart';
import 'package:itsmilife/pages/professional/homepro.dart';
import 'package:itsmilife/services/NetworkManager.dart';
import 'package:intl/intl.dart';
import 'package:itsmilife/widgets/bottomNavBar.dart';
import 'package:itsmilife/widgets/conversationListPro.dart';
import '../../../widgets/conversationList.dart';
import '../../normal_user/chat/model/chatUsersModel.dart';
import 'chat_service.dart';
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
        NetworkManager.get("users/" + ProfileData.id + "/discussionsTrue")
            .then((val) {
      print(val.data);
      if (val.data != "No discussions found" && val.data['success'] == true) {
        List<ChatUsers> chatUsers = [];
        for (int i = 0; i != val.data['message'].length; i++) {
          String date = val.data['message'][i]['date'];
          DateTime dateTime = DateTime.parse(date);
          dateTime = dateTime.toLocal();
          String formattedDate = DateFormat('jm').format(dateTime);
          ChatUsers discussion = new ChatUsers(
              ID: val.data['message'][i]['_id'],
              patientID: val.data['message'][i]['professional']['_id'],
              proID: val.data['message'][i]['patient']['_id'],
              imageURL: val.data['message'][i]['patient']['avatar'],
              name: val.data['message'][i]['patient']['username'],
              time: formattedDate,
              LastMessage: (val.data['message'][i]['messages'] != null &&
                      val.data['message'][i]['messages'].isNotEmpty)
                  ? val.data['message'][i]['messages']
                      [val.data['message'][i]['messages'].length - 1]['content']
                  : "Démarrez la conversation !");
          chatUsers.add(discussion);
        }
        return chatUsers;
      } else {
        throw Exception();
      }
    });
  }

    @override
  void dispose() {
    super.dispose();
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
                      child: Icon(Icons.arrow_back, color: Colors.black),
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
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      NotificationPage(),
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
                  if (chatUsers.length == 0) {
                    return Container();
                  }
                  return ListView.builder(
                    itemCount: chatUsers.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 16),
                    itemBuilder: (context, index) {
                      final discussion = chatUsers[index];
                      return Dismissible(
                          key: Key(discussion.ID),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {},
                          background: Container(
                            alignment: AlignmentDirectional.centerEnd,
                            color: Colors.red,
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          child: ConversationListPro(
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
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
