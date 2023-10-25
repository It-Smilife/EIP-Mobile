import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itsmilife/pages/common/chat/model/chatMessageModel.dart';
import 'package:openai_client/openai_client.dart';
import 'package:openai_client/src/model/openai_chat/chat_message.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:itsmilife/pages/common/settings/darkModeProvider.dart';
import 'package:provider/provider.dart';
import 'package:itsmilife/pages/common/settings/languageProvider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:jumping_dot/jumping_dot.dart';

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
  final _scrollController = ScrollController();
  final player = AudioPlayer();
  final bot = AudioPlayer();
  bool isTyping = false;

  @override
  void initState() {
    super.initState();
    _conf = OpenAIConfiguration(
        apiKey: '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');
    _client = OpenAIClient(configuration: _conf);
  }

  @override
  void dispose() {
    _scrollController.dispose();
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
      player.play(UrlSource('https://bigsoundbank.com/UPLOAD/wav/1313.wav'));
      _chatMessages.add(chatMessage);
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
      isTyping = true;
    });
    try {
      final chat = await _client.chat.create(
        model: 'gpt-3.5-turbo',
        messages: [
          ChatMessage(
            role: 'system',
            content:
                "Tu es un expert en psychologie et un psychologue depuis 25 ans, ton role est de m'aider a mieux comprendre mes émotions et de surmonter mes moments difficiles. Tu dois parler avec un ton très amicale et toujours essayer de me reconforter du mieux possible. Je souhaite que toute tes réponses soit le plus résumer possibles et que les informations sont claires et consisces. Les réponses ne doivent pas dépasser plus de 100 charactère. Tu dois repondre uniquement aux questions concernant le bien-être et la santé mentale",
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
        bot.play(UrlSource('https://bigsoundbank.com/UPLOAD/wav/1111.wav'));
        _chatMessages.add(botMessage);
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
        isTyping = false;
      });
    } catch (e) {
      print(e);
    }
  }

  Widget _buildChatMessage(ChatMessagee message) {
    final alignment =
        message.isSentByUser ? Alignment.topRight : Alignment.topLeft;
    final _color = message.isSentByUser ? Colors.blue[200] : Colors.grey[100];
    return Container(
      padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
      child: Align(
        alignment: alignment,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: message.isSentByUser
                ? const BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  )
                : const BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(5),
                  ),
            color: _color,
          ),
          padding: EdgeInsets.all(16),
          child: Text(
            message.message,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }

  Widget _IsWritting() {
    final alignment = Alignment.topLeft;
    final _color = Colors.grey[100];
    return Container(
      padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
      child: Align(
        alignment: alignment,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(5),
                  ),
            color: _color,
          ),
          padding: EdgeInsets.all(16),
          child: JumpingDots(
          color: Colors.deepPurpleAccent,
          radius: 10,
          numberOfDots: 3,
          animationDuration: Duration(milliseconds: 200),
        ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<DarkModeProvider>(context);
    final lang = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[200],
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
                    CupertinoIcons.back,
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
                        lang.lang == "English" ? "Online" : "En ligne",
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
            controller: _scrollController,
            itemCount: _chatMessages.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10, bottom: 60),
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return _buildChatMessage(_chatMessages[index]);
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 70,
              width: double.infinity,
              color: Colors.transparent,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[
                            200], // Choisissez la couleur qui convient le mieux à votre thème
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        maxLines: null,
                        expands: true,
                        controller: _textController,
                        decoration: InputDecoration(
                          hintText: (lang.lang == "English" && !isTyping)
                              ? "Write message..." : (lang.lang == "English" && isTyping) ? "Is writing ..." : (lang.lang != "English" && !isTyping) ?
                               "Ecrivez un message..." : "Est entrain d'écrire ...",
                          hintStyle: TextStyle(color: Colors.black54, fontWeight: (isTyping) ? FontWeight.bold : FontWeight.normal),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(
                              10), // C'est pour donner un peu d'espace à l'intérieur de la zone de texte
                        ),
                        textAlignVertical: TextAlignVertical.center,
                        onSubmitted: (value) {
                          _sendMessage(value);
                          _textController.clear();
                        },
                      ),
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
                    backgroundColor: Colors.deepPurpleAccent,
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
