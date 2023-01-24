import 'package:flutter/material.dart';
import 'package:itsmilife/pages/common/chat/model/chatMessageModel.dart';

import '../../../widgets/conversationList.dart';
import 'model/chatUsersModel.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatUsers> chatUsers = [
    ChatUsers(
        name: "Jane Russel",
        LastMessage: "Last",
        imageURL: "assets/avatar.png",
        proID: "1",
        patientID: "1",
        time: "Now"),
    ChatUsers(
        name: "Glady's Murphy",
        LastMessage: "That's Great",
        imageURL: "assets/avatar.png",
        proID: "1",
        patientID: "1",
        time: "Yesterday"),
    ChatUsers(
        name: "Jorge Henry",
        LastMessage: "Hey where are you?",
        imageURL: "assets/avatar.png",
        proID: "1",
        patientID: "1",
        time: "31 Mar"),
    ChatUsers(
        name: "Philip Fox",
        LastMessage: "Busy! Call me in 20 mins",
        imageURL: "assets/avatar.png",
        proID: "1",
        patientID: "1",
        time: "28 Mar"),
    ChatUsers(
        name: "Debra Hawkins",
        LastMessage: "Thankyou, It's awesome",
        imageURL: "assets/avatar.png",
        proID: "1",
        patientID: "1",
        time: "23 Mar"),
    ChatUsers(
        name: "Jacob Pena",
        LastMessage: "will update you in evening",
        imageURL: "assets/avatar.png",
        proID: "1",
        patientID: "1",
        time: "17 Mar"),
    ChatUsers(
        name: "Andrey Jones",
        LastMessage: "Can you please share the file?",
        imageURL: "assets/avatar.png",
        proID: "1",
        patientID: "1",
        time: "24 Feb"),
    ChatUsers(
        name: "John Wick",
        LastMessage: "How are you?",
        imageURL: "assets/avatar.png",
        proID: "1",
        patientID: "1",
        time: "18 Feb"),
  ];

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
                        children: const <Widget>[
                          Icon(
                            Icons.add,
                            color: Color.fromARGB(255, 255, 255, 255),
                            size: 20,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            "Add New",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
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
            ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 16),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ConversationList(
                  name: chatUsers[index].name,
                  messageText: chatUsers[index].LastMessage,
                  imageUrl: chatUsers[index].imageURL,
                  time: chatUsers[index].time,
                  isMessageRead: (index == 0 || index == 3) ? true : false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
