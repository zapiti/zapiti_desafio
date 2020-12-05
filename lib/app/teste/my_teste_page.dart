import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:zapiti_desafio/app/component/load/load_elements.dart';
import 'package:zapiti_desafio/app/component/state_view/empty_view_mobile.dart';
import 'package:zapiti_desafio/app/modules/home/modules/init/model/message.dart';
import 'package:zapiti_desafio/app/modules/home/modules/init/model/news.dart';
import 'package:zapiti_desafio/app/modules/home/modules/init/model/user.dart';
import 'package:zapiti_desafio/app/modules/home/modules/init/widget/mobile/item_list_news.dart';
import 'package:zapiti_desafio/app/utils/date_utils.dart';

///Este e apenas uma classe te teste
class MyTestePage extends StatelessWidget {
  MyTestePage({this.firestore});

  final FirebaseFirestore firestore;


  Future<void> _addMessage() async {
    await firestore.collection('POST2').add(News(id: Uuid().v4(),
            user: MyUser(name: "testador"),
            message: Message(
                content: "Isto é um post de teste",
                created_at: DateUtils.parseDateTimeFormat(DateTime.now(),
                    format: "dd-MM-yyyy HH:mm")))
        .toMap());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exemplo de classe teste'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('POST2').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return loadElements(context);
          final messageCount = snapshot.data.docs.length;
          return ListView.builder(
            itemCount: messageCount,
            itemBuilder: (_, int index) {
              List docus  = snapshot.data.docs;
              if(docus.isEmpty){
                return emptyViewMobile(context);
              }else{
                final document = docus[index];

                return Column(
                  children: [
                    ItemListNews(News.fromMap(document.data()), index),
                    Text('Mensagem ${index + 1} de $messageCount')
                  ],
                );
              }

            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMessage,
        tooltip: 'Adicionar',
        child: const Icon(Icons.add),
      ),
    );
  }
}
