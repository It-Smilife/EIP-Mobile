import 'package:flutter/material.dart';
import 'package:itsmilife/pages/common/profile.dart';
import 'package:itsmilife/pages/normal_user/chat/chatProUser.dart';
import 'package:itsmilife/services/NetworkManager.dart';

import '../pages/common/chat/chatDetailPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' as cupertino;

class AddProList extends StatefulWidget {
  String username;
  String id;
  String imgURL;
  AddProList({required this.username, required this.id, required this.imgURL});

  @override
  _AddProListState createState() => _AddProListState();
}

class _AddProListState extends State<AddProList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCupertinoModalPopup(
          context: context,
          builder: (BuildContext context) {
            return CupertinoActionSheet(
              title: Text(widget.username),
              message: Text(
                  "Voulez-vous démarrez une conversation avec cet utilisateur ?"),
              actions: <Widget>[
                CupertinoActionSheetAction(
                  child: Text("Ajouter"),
                  onPressed: () {
                    NetworkManager.post("discussions", {
                      "professional": widget.id,
                      "patient": ProfileData.id
                    }).then((val) {
                      if (val.data['success'] == true) {
                        NetworkManager.put("users/" + ProfileData.id, {
                          "discussions": val.data['message']['_id']
                        }).then((val) {
                          if (val.data['success'] == true) {
                            print("Sucess");
                          } else {
                            throw Exception('Failed to change user');
                          }
                        });
                        NetworkManager.put("users/" + widget.id, {
                          "discussions": val.data['message']['_id']
                        }).then((val) {
                          if (val.data['success'] == true) {
                            print("Success");
                          } else {
                            throw Exception('Failed to change user');
                          }
                        });

                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const ChatProUser(),
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
                      } else {
                        throw Exception('Failed to create discussion');
                      }
                    });
                  },
                ),
                CupertinoActionSheetAction(
                  child: Text("Annuler"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  isDestructiveAction: true,
                ),
              ],
              cancelButton: CupertinoActionSheetAction(
                child: Text("Fermer"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            );
          },
        );
      },
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.imgURL),
                    maxRadius: 30,
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
                            widget.username,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) {
                    return CupertinoActionSheet(
                      title: Text(widget.username),
                      message: Text(
                          "Voulez-vous démarrez une conversation avec cet utilisateur ?"),
                      actions: <Widget>[
                        CupertinoActionSheetAction(
                          child: Text("Ajouter"),
                          onPressed: () {
                            NetworkManager.post("discussions", {
                              "professional": widget.id,
                              "patient": ProfileData.id
                            }).then((val) {
                              if (val.data['success'] == true) {
                                NetworkManager.put("users/" + ProfileData.id, {
                                  "discussions": val.data['message']['_id']
                                }).then((val) {
                                  if (val.data['success'] == true) {
                                    print("Sucess");
                                  } else {
                                    throw Exception('Failed to change user');
                                  }
                                });
                                NetworkManager.put("users/" + widget.id, {
                                  "discussions": val.data['message']['_id']
                                }).then((val) {
                                  if (val.data['success'] == true) {
                                    print("Sucess");
                                  } else {
                                    throw Exception('Failed to change user');
                                  }
                                });
                                Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        ChatProUser(),
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
                                        Duration(milliseconds: 300),
                                  ),
                                );
                              } else {
                                throw Exception('Failed to create discussion');
                              }
                            });
                          },
                        ),
                        CupertinoActionSheetAction(
                          child: Text("Annuler"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          isDestructiveAction: true,
                        ),
                      ],
                      cancelButton: CupertinoActionSheetAction(
                        child: Text("Fermer"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                );
              },
              child: Icon(
                cupertino.CupertinoIcons.add,
                color: cupertino.CupertinoColors.systemBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
