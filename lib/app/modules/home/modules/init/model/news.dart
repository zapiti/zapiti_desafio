


import 'package:uuid/uuid.dart';
import 'package:zapiti_desafio/app/modules/home/modules/init/model/message.dart';
import 'package:zapiti_desafio/app/modules/home/modules/init/model/user.dart';
import 'package:zapiti_desafio/app/utils/date_utils.dart';

class News {
  String id;
  MyUser user;
  Message message;
  DateTime date;
  News({this.user, this.message,this.id});

  Map<String, dynamic> toMap() {

    return {
      'id': id ?? Uuid().v4(),
      'user': user?.toMap(),
      'message': message?.toMap(),
      'date':DateUtils.parseDateTimeFormat(date ??  DateTime.now(),format: "dd-MM-yyyy") ,
    };
  }

  factory News.fromMap(dynamic map) {
    if (null == map) return null;
    var temp;
    return News(
      id:map['id'].toString(),
      user: MyUser.fromMap(map['user']),
      message: Message.fromMap(map['message']),
    );
  }


}