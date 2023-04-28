import 'package:flutter/material.dart';
import 'package:itsmilife/pages/common/profile.dart';
import 'package:itsmilife/services/NetworkManager.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../normal_user/chat/model/chatMessageModel.dart';

class ChatDetailPage extends StatefulWidget {
  late String discussionId;
  late String name;
  ChatDetailPage({Key? key, required this.discussionId, required this.name})
      : super(key: key);

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  late Future<List<ChatMessage>> list_messages;
  List<ChatMessage>? chatMessagesFuture = [];

  Future<List<ChatMessage>> fetchMessages() async {
    return await NetworkManager.get("discussions/" + widget.discussionId)
        .then((value) {
      if (value.data["success"] == true) {
        List<ChatMessage> messages = [];
        for (int i = 0; i != value.data['message']['messages'].length; i++) {
          messages.add(ChatMessage(
              message: value.data['message']['messages'][i]['content'],
              messageID: value.data['message']['messages'][i]['_id'],
              date: value.data['message']['messages'][i]['date'],
              id: value.data['message']['messages'][i]['user'] == ProfileData.id
                  ? 'sender'
                  : 'receiver'));
        }
        return messages;
      } else {
        // If that call was not successful, throw an error.
        return throw Exception('Failed to load messages');
      }
    });
  }

  late String _newMessage = "";
  final _textController = TextEditingController();
  late IO.Socket socket;

  void _addMessage(ChatMessage message) {
    if (mounted) {
      setState(() {
        chatMessagesFuture!.add(message);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    list_messages = fetchMessages() as Future<List<ChatMessage>>;
    print(widget.discussionId);
    // Create Socket.IO instance
    socket = IO.io('http://51.145.251.116:81', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    // Connect to server
    socket.connect();

    socket.on('connect', (_) {
      print('Connected to server');
    });

    // socket.emit('join', widget.discussionId);
    print(widget.discussionId);
    socket.emit('join', widget.discussionId);

    // Listen for new messages
    socket.on('newMessage', (data) {
      print(data);
      // setState(() {
      _addMessage(ChatMessage(
        message: data['content'],
        messageID: data['_id'],
        date: DateTime.now().toString(),
        id: 'receiver',
      ));
      _textController.clear();
      // });
    });

    @override
    void dispose() {
      socket.disconnect();
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    void _sendMessage(String message) {
      if (message.isNotEmpty) {
        socket.emit('newMessage', {
          'content': message,
          'discussion': widget.discussionId,
          'user': ProfileData.id,
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    socket.disconnect();
                    socket.dispose();
                    _textController.dispose();
                    super.dispose();
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage("assets/avatarpro.png"),
                  maxRadius: 20,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.name,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Online",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.settings,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          FutureBuilder<List<ChatMessage>>(
            future: fetchMessages(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                chatMessagesFuture = snapshot.data;
                return ListView.builder(
                  itemCount: chatMessagesFuture!.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.only(
                          left: 14, right: 14, top: 10, bottom: 10),
                      child: Align(
                        alignment: (chatMessagesFuture![index].id == "receiver"
                            ? Alignment.topLeft
                            : Alignment.topRight),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (chatMessagesFuture![index].id == "receiver"
                                ? Colors.grey.shade200
                                : Colors.blue[200]),
                          ),
                          padding: EdgeInsets.all(16),
                          child: Text(
                            chatMessagesFuture![index].message,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      onChanged: (text) => _newMessage = text,
                      decoration: InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      _sendMessage(_textController.text);
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
