import 'package:flutter/material.dart';
import 'package:zapiti_desafio/app/modules/home/modules/chat/widget/chat/chat_perspective.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return ChatPerspective();
  }
}
