import 'package:flutter/material.dart';
import 'package:itsmilife/pages/common/profile.dart';
import 'package:itsmilife/pages/normal_user/chat/chatProUser.dart';
import 'package:itsmilife/pages/professional/chatPro/notificationCenter.dart';
import 'package:itsmilife/pages/professional/chatPro/patient_list.dart';
import 'package:itsmilife/services/NetworkManager.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' as cupertino;

class AddPatientList extends StatefulWidget {
  String username;
  String id;
  String id_discussion;
  String imgURL;
  AddPatientList({required this.username, required this.id, required this.id_discussion,required this.imgURL});

  @override
  _AddPatientListState createState() => _AddPatientListState();
}

class _AddPatientListState extends State<AddPatientList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                    NetworkManager.put("discussions/" + widget.id_discussion, {
                      "status": true,
                    }).then((val) {
                      if (val.data['success'] == true) {
                        NetworkManager.put("users/" + ProfileData.id, {
                          "discussions": widget.id_discussion
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
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const ListPatient(),
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
              child: Icon(
                cupertino.CupertinoIcons.check_mark,
                color: cupertino.CupertinoColors.systemBlue,
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
                          child: Text("Supprimer"),
                          onPressed: () {
                            NetworkManager.delete("discussions/" + widget.id_discussion,).then((val) {
                              if (val.data['success'] == true) {
                                Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
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
                cupertino.CupertinoIcons.delete,
                color: cupertino.CupertinoColors.systemRed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
