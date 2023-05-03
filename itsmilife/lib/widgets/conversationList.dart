import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:itsmilife/pages/normal_user/chat/chatDetailPage.dart';
import 'package:itsmilife/pages/normal_user/homepage/homepage.dart';
import 'package:itsmilife/pages/professional/chatPro/chatdetailPro.dart';
import 'package:itsmilife/services/NetworkManager.dart';

import '../pages/professional/chatPro/chat_service.dart';

class ConversationList extends StatefulWidget {
  String name;
  String messageText;
  String imageUrl;
  String discussion_id;
  String time;
  bool isMessageRead;
  ConversationList(
      {required this.name,
      required this.messageText,
      required this.imageUrl,
      required this.discussion_id,
      required this.time,
      required this.isMessageRead});

  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                ChatDetailPage(discussionId: widget.discussion_id, name: widget.name, imgUrl: widget.imageUrl),
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
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                   FutureBuilder<Uint8List>(
                    future: NetworkManager.getFile(widget.imageUrl),
                    builder: (BuildContext context,
                        AsyncSnapshot<Uint8List> snapshot) {
                      if (snapshot.hasData) {
                        return Stack(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  MemoryImage(snapshot.data ?? Uint8List(0)),
                              maxRadius: 30,
                            ),
                          ],
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.name,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.messageText,
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                                fontWeight: widget.isMessageRead
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              widget.time,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: widget.isMessageRead
                      ? FontWeight.bold
                      : FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
