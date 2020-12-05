import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zapiti_desafio/app/app_bloc.dart';
import 'package:zapiti_desafio/app/component/dialog/dialog_generic_calendar.dart';
import 'package:zapiti_desafio/app/component/dialog/dialog_generic_textfield.dart';
import 'package:zapiti_desafio/app/modules/home/modules/init/model/message.dart';
import 'package:zapiti_desafio/app/modules/home/modules/init/model/news.dart';
import 'package:zapiti_desafio/app/modules/home/modules/init/model/user.dart';
import 'package:zapiti_desafio/app/utils/date_utils.dart';

class HomeBloc extends Disposable {
  var selectedMenu = BehaviorSubject<int>.seeded(0);
  var appBloc = Modular.get<AppBloc>();
  final POSTS = "POST";
  final LIST = "LISTPOST";

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    selectedMenu.drain();
  }

  void creatPostOrEdit(context, {News myNews, Function onSuccess}) {
    var controllPost = TextEditingController();
    controllPost.text = myNews?.message?.content;
    var news = myNews ?? News();
    news.user = appBloc.getCurrentUserValue();
    news.message = Message();


    showTextFieldGenericDialog(
        context: context,
        title: news.id != null ? "Editar postagem" : "Criar postagem",
        inputFormatters: [LengthLimitingTextInputFormatter(280)],
        minSize: 30,
        lines: 4,
        erroText: "Escreva entre 30 e 280 caracteres.",
        controller: controllPost,
        positiveText: news.id != null ? "Editar" : "Enviar",
        positiveCallback: () {
          news.message.created_at = DateUtils.parseDateTimeFormat(
              DateTime.now(),
              format: "dd-MM-yyyy HH:mm");
          news.message.content = controllPost.text;
          controllPost.clear();
          createRecord(news);
          if (onSuccess != null) {
            onSuccess();
          }
        });
  }

  void createRecord(News news) async {
    FirebaseFirestore db = GetIt.I.get<FirebaseFirestore>();

    if (news.id == null) {
      DocumentReference ref = await db.collection(POSTS).add(news.toMap());
      print(ref.id);
    } else {
      try {
        getDataById(news.id, db).then((value) async {
          print("Atualizacao ${value.docs}");
          await db.runTransaction((Transaction myTransaction) async {
            if (value.docs.isNotEmpty) {
              myTransaction.set(value.docs.first.reference, news.toMap());
            }
          });
        });
      } catch (e) {
        print(e);
      }
    }
  }

  void filterPost(BuildContext context) {
    showGenericDialogCalendar(context: context, selectedDay: DateTime.now());
  }

  Future getDataById(String index, FirebaseFirestore db) =>
      db.collection(POSTS).where("id", isEqualTo: index).get();

  Future<void> deletePost(BuildContext context,
      {News myNews, Function onSuccess}) async {
    FirebaseFirestore db = GetIt.I.get<FirebaseFirestore>();
    try {
      getDataById(myNews.id, db).then((value) async {
        print("Deletado ${value.docs}");

        await db.runTransaction((Transaction myTransaction) async {
          if (value.docs.isNotEmpty) {
            myTransaction.delete(value.docs.first.reference);
          }
          onSuccess();
        });
      });
    } catch (e) {
      print(e);
      onSuccess();
    }
  }
}
