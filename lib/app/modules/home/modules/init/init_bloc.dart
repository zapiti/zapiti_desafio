import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zapiti_desafio/app/app_bloc.dart';
import 'package:zapiti_desafio/app/modules/home/modules/init/model/news.dart';
import 'package:zapiti_desafio/app/utils/date_utils.dart';
import 'package:zapiti_desafio/app/utils/object/object_utils.dart';

import '../../home_bloc.dart';
import 'core/init_repository.dart';

class InitBloc extends Disposable {
  final _repository = Modular.get<InitRepository>();
  final homeBloc = Modular.get<HomeBloc>();
  final listFakePost = BehaviorSubject<List<News>>();
  final listRealPost = BehaviorSubject<List<News>>();
  final POSTS = "POST";
  final LIST = "LISTPOST";

  getFakeListPost() async {
    var response = await _repository.getListJsonFake();

    if (response.error == null) {
      listFakePost.sink
          .add(ObjectUtils.parseToObjectList<News>(response.content));
    }
  }

  getRealListPost() async {
    var appBloc = Modular.get<AppBloc>();
    listRealPost.sink.add(null);
    appBloc.dateSelectedSubject.stream.listen((event) {
      var date = event ?? DateTime.now();
      FirebaseFirestore db = GetIt.I.get<FirebaseFirestore>();

      try {
        db
            .collection(POSTS)
            .where('date',
                isEqualTo: DateUtils.parseDateTimeFormat(date ?? DateTime.now(),
                    format: "dd-MM-yyyy"))
            .snapshots()
            .listen((QuerySnapshot docSnapshot) {
          var docs = docSnapshot.docs;
          docs.sort((a, b) {
            var adate = News.fromMap(a);
            var bdate = News.fromMap(b);
            return adate.message.created_at.compareTo(bdate.message
                .created_at); //to get the order other way just switch `adate & bdate`
          });
          if (docSnapshot.size != 0) {
            listRealPost.sink
                .add(docs.reversed.map<News>((e) => News.fromMap(e.data())).toList());
          } else {
            listRealPost.sink.add([]);
          }
        });
      } catch (e) {
        print(e);
        listRealPost.sink.add([]);
      }
    });
  }

  @override
  void dispose() {
    listRealPost.drain();
    listFakePost.drain();
    listFakePost.close();
  }

  void deletePost(BuildContext context, News news) {
    homeBloc.deletePost(context, myNews: news, onSuccess: () {
      listRealPost.sink.add(null);
      getRealListPost();
    });
  }

  void editPost(BuildContext context, News news) {
    homeBloc.creatPostOrEdit(context, myNews: news, onSuccess: () {
      listRealPost.sink.add(null);
      getRealListPost();
    });
  }
}
