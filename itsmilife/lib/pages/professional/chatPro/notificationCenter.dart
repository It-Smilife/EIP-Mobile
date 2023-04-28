import 'package:flutter/material.dart';
import 'package:itsmilife/pages/professional/chatPro/patient_list.dart';
import 'package:provider/provider.dart';

import '../../../services/NetworkManager.dart';
import '../../common/profile.dart';
import '../../common/settings/darkModeProvider.dart';
import '../../normal_user/chat/model/chatUsersModel.dart';
import 'addpatient.dart';

class NotificationPage extends StatefulWidget {

  NotificationPage({super.key});
    @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late Future<List<UserPatient>> _UsersPatientFuture;
  

  @override
  void initState() {
    super.initState();
    _UsersPatientFuture = NetworkManager.get(
            "users/" + ProfileData.id + "/uncontactedUsers")
        .then((val) {
      if (val.data['success'] == true) {
        List<UserPatient> chatUsers = [];
        for (int i = 0; i != val.data['message'].length; i++) {
          UserPatient user = new UserPatient(
              id: val.data['message'][i]['patient']['_id'],
              id_discussion: val.data['message'][i]['discussionId'],
              username: val.data['message'][i]['patient']['username'],
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
    final darkMode = Provider.of<DarkModeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  ListPatient(),
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
          color: Colors.black,
        ),
        centerTitle: true,
        backgroundColor: darkMode.darkMode
            ? const Color.fromARGB(255, 58, 50, 83)
            : const Color.fromARGB(255, 255, 255, 255),
        title: Text("Notifications",
            style: const TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold)),
      ),
      body: FutureBuilder<List<UserPatient>>(
              future: _UsersPatientFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 16),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return AddPatientList(
                        username: snapshot.data![index].username,
                        id: snapshot.data![index].id,
                        id_discussion: snapshot.data![index].id_discussion,
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
    );
  }
}
