import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/settings/darkModeProvider.dart';

class NotificationPage extends StatelessWidget {
  final List<ContactRequest> requests;

  NotificationPage({required this.requests});

  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<DarkModeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
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
      body: ListView.builder(
        itemCount: requests.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(requests[index].avatarUrl),
            ),
            title: Text(requests[index].username),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // TODO: Implement accept button logic
                  },
                  child: Text('Accept'),
                ),
                SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () {
                    // TODO: Implement decline button logic
                  },
                  child: Text('Decline'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ContactRequest {
  final String username;
  final String avatarUrl;

  ContactRequest({required this.username, required this.avatarUrl});
}
