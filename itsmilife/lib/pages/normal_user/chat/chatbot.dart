import 'package:flutter/material.dart';
import 'package:itsmilife/pages/common/chat/model/chatMessageModel.dart';
import 'package:openai_client/openai_client.dart';
import 'package:openai_client/src/model/openai_chat/chat_message.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class ChatBot extends StatefulWidget {
  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final _textController = TextEditingController();
  final _chatMessages = <ChatMessagee>[];
  final _uuid = Uuid();
  final _dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  late OpenAIConfiguration _conf;
  late OpenAIClient _client;
  final _modelId = 'gpt-3.5-turbo';

  @override
  void initState() {
    super.initState();
    _conf = OpenAIConfiguration(apiKey: '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');
    _client = OpenAIClient(configuration: _conf);
  }

  @override
  void dispose() {
    _client.close();
    super.dispose();
  }

  
  Future<void> _sendMessage(String message) async {
    final chatMessage = ChatMessagee(
      id: _uuid.v4(),
      message: message,
      date: _dateFormat.format(DateTime.now()),
      isSentByUser: true,
    );
    setState(() {
      _chatMessages.add(chatMessage);
    });
    try {
      final chat = await _client.chat.create(
    model: 'gpt-3.5-turbo',
    messages: [
      ChatMessage(
        role: 'system',
        content: "Tu es un expert en psychologie et un psychologue depuis 25 ans, ton role est de m'aider a mieux comprendre mes émotions et de surmonter mes moments difficiles. Tu dois parler avec un ton très amicale et toujours essayer de me reconforter du mieux possible. Je souhaite que toute tes réponses soit le plus résumer possibles et que les informations sont claires et consisces. Les réponses ne doivent pas dépasser plus de 100 charactère.",
      ),
      ChatMessage(
        role: 'user',
        content: message,
      )
    ],
  ).data;
      final response = chat.choices.first.message.content;
      final botMessage = ChatMessagee(
        id: _uuid.v4(),
        message: response,
        date: _dateFormat.format(DateTime.now()),
        isSentByUser: false,
      );
      setState(() {
        _chatMessages.add(botMessage);
      });
    } catch (e) {
      print(e);
    }
  }

  Widget _buildChatMessage(ChatMessagee message) {
    final alignment = message.isSentByUser ? Alignment.topRight : Alignment.topLeft;
    final color = message.isSentByUser ? Colors.blue[200] : Colors.grey[200];
    return Container(
      padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
      child: Align(
        alignment: alignment,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: color,
          ),
          padding: EdgeInsets.all(16),
          child: Text(
            message.message,
            style: TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  backgroundImage: AssetImage("assets/logosmile.png"),
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
                        "Smile",
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
                  Icons.circle,
                  color: Colors.green,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: _chatMessages.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return _buildChatMessage(_chatMessages[index]);
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
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: "Write message...",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none,
                      ),
                      onSubmitted: (value) {
                        _sendMessage(value);
                        _textController.clear();
                      },
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      final value = _textController.text.trim();
                      if (value.isNotEmpty) {
                        _sendMessage(value);
                        _textController.clear();
                      }
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