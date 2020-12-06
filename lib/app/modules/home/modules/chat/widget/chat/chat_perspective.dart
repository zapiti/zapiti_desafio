import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:zapiti_desafio/app/app_bloc.dart';
import 'package:zapiti_desafio/app/component/chat/chat_view.dart';
import 'package:zapiti_desafio/app/component/chat/models/chat_message.dart';
import 'package:zapiti_desafio/app/component/chat/models/chat_user.dart';
import 'package:zapiti_desafio/app/component/chat/models/reply.dart';
import 'package:zapiti_desafio/app/image/image_path.dart';
import 'package:zapiti_desafio/app/utils/string/string_file.dart';
import 'package:zapiti_desafio/app/utils/theme/app_theme_utils.dart';

class ChatPerspective extends StatelessWidget {
  ChatPerspective();

  @override
  Widget build(BuildContext context) {
    return _MyChatPage();
  }
}

class _MyChatPage extends StatefulWidget {
  @override
  _MyChatPageState createState() => _MyChatPageState();
}

class _MyChatPageState extends State<_MyChatPage> {
  final GlobalKey<MyChatState> _chatViewKey = GlobalKey<MyChatState>();
  var appBloc = Modular.get<AppBloc>();
  ChatUser user;
  var textController = TextEditingController();
  var controller = TextEditingController();
  ChatUser otherUser;
  FirebaseFirestore db = GetIt.I.get<FirebaseFirestore>();
  List<ChatMessage> messages = List<ChatMessage>();
  var m = List<ChatMessage>();

  var i = 0;

  @override
  void initState() {
    var appBloc = Modular.get<AppBloc>();
    var current = appBloc.getCurrentUserValue();

    user = ChatUser(
      name: current.name,
      firstName: current.name,
      lastName: "",
      
      uid: current?.uid,
     avatar:current.profile_picture ?? ImagePath.radom(0),
    );
    otherUser = ChatUser(
      name: "Nathan",
      firstName: "Nathan",
      lastName: "",
      uid: "1565",     avatar:current.profile_picture ?? ImagePath.radom(0),
    );
    super.initState();
  }

  void systemMessage() {
    Timer(Duration(milliseconds: 300), () {
      if (i < 6) {
        setState(() {
          messages = [...messages, m[i]];
        });
        i++;
      }
      Timer(Duration(milliseconds: 300), () {
        _chatViewKey.currentState.scrollController
          ..animateTo(
            _chatViewKey.currentState.scrollController.position.maxScrollExtent,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
          );
      });
    });
  }

  void onSend(ChatMessage message, TextEditingController textController,
      FirebaseFirestore db,
      {bool ignore: false}) async {
    if (textController.text != message.text || ignore) {
      textController.text = message.text;
      var _dateTime = DateTime.now();

      print(message.toJson());
      var documentReference = db
          .collection('Messages')
          .doc("Attendance")
          .collection("admin")
          .doc(_dateTime.millisecondsSinceEpoch.toString());

      await db.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          message.toJson(),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: db
              .collection('Messages')
              .doc("Attendance")
              .collection("admin")
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
              );
            } else {
              List<DocumentSnapshot> items = snapshot.data.documents;
              var messages =
                  items.map((i) => ChatMessage.fromJson(i.data())).toList();
              return ChaView(
                key: _chatViewKey,
                inverted: false,
                onSend: (msg) => onSend(msg, textController, db),
                sendOnEnter: true,
                textInputAction: TextInputAction.send,
                user: user,
                // chatFooterBuilder: () {
                //   return _chatField(widget.attendance);
                // },
                sendButtonBuilder: (sender) {
                  return Container(
                    padding: const EdgeInsets.all(15.0),
                    margin: EdgeInsets.only(right: 10, bottom: 8),
                    decoration: BoxDecoration(
                        color: AppThemeUtils.colorPrimary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 3),
                              blurRadius: 5,
                              color: Colors.grey)
                        ]),
                    child: InkWell(
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      onTap: sender,
                    ),
                  );
                  // return IconButton(
                  //   onPressed: sender,
                  //   icon: Icon(
                  //     Icons.send,
                  //     color: Color(0xff3E8DF3),
                  //   ),
                  // );
                },
                inputDecoration: InputDecoration.collapsed(
                    hintText: StringFile.adicioneAMessage),
                dateFormat: DateFormat('dd-MMMM-yyyy', "pt_br"),
                timeFormat: DateFormat('HH:mm'),
                messages: messages,
                showUserAvatar: false,
                showAvatarForEveryMessage: false,
                scrollToBottom: true,
                onPressAvatar: (ChatUser user) {
                  print("OnPressAvatar: ${user.name}");
                },
                onLongPressAvatar: (ChatUser user) {
                  print("OnLongPressAvatar: ${user.name}");
                },
                inputMaxLines: 5,
                messageContainerPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                alwaysShowSend: true,
                inputTextStyle: TextStyle(fontSize: 16.0),
                inputContainerStyle: BoxDecoration(
                  border: Border.all(width: 0.0),
                  color: Colors.white,
                ),
                onQuickReply: (Reply reply) {
                  setState(() async {
                    var _dateTime = await DateTime.now();

                    messages.add(ChatMessage(
                        text: reply.value, createdAt: _dateTime, user: user));

                    messages = [...messages];
                  });

                  Timer(Duration(milliseconds: 300), () {
                    _chatViewKey.currentState.scrollController
                      ..animateTo(
                        _chatViewKey.currentState.scrollController.position
                            .maxScrollExtent,
                        curve: Curves.easeOut,
                        duration: const Duration(milliseconds: 300),
                      );

                    if (i == 0) {
                      systemMessage();
                      Timer(Duration(milliseconds: 600), () {
                        systemMessage();
                      });
                    } else {
                      systemMessage();
                    }
                  });
                },
                onLoadEarlier: () {
                  print("laoding.");
                },
                shouldShowLoadEarlier: false,
                showTraillingBeforeSend: true,
                trailing: <Widget>[],
              );
            }
          }),
    );
  }
}

void onSend(ChatMessage message, TextEditingController textController,
    FirebaseFirestore db,
    {bool ignore: false}) async {
  if (textController.text != message.text || ignore) {
    textController.text = message.text;
    var _dateTime = DateTime.now();

    print(message.toJson());
    var documentReference = db
        .collection('Messages')
        .doc("Attendance")
        .collection("admin")
        .doc(_dateTime.millisecondsSinceEpoch.toString());

    await db.runTransaction((transaction) async {
      await transaction.set(
        documentReference,
        message.toJson(),
      );
    });
  }
  /* setState(() {
      messages = [.messages, message];
      print(messages.length);
    });

    if (i == 0) {
      systemMessage();
      Timer(Duration(milliseconds: 600), () {
        systemMessage();
      });
    } else {
      systemMessage();
    } */
}

//
