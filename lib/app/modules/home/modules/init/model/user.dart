import 'package:flutter_modular/flutter_modular.dart';
import 'package:zapiti_desafio/app/app_bloc.dart';
import 'package:zapiti_desafio/app/image/image_path.dart';

class MyUser {
  String uid;
  String name;
  String profile_picture;
  String phone;
  String email;

  MyUser({this.uid, this.name, this.profile_picture, this.phone, this.email});

  factory MyUser.fromMap(dynamic map) {
    if (null == map) return null;
    return MyUser(
      uid: (map['uid']).toString(),
      name: ((map['name'].toString().isEmpty || map['name'] == null)
              ? "Anônimo"
              : map['name'])
          .toString(),
      profile_picture: map['profile_picture']?.toString(),
      phone: map['phone']?.toString(),
      email: map['email']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    final appBloc = Modular.get<AppBloc>();
    final uid2 = appBloc.getCurrentUserValue();
    return {
      'uid': uid2.uid.toString(),
      'name': uid2.name,
      'profile_picture': profile_picture ?? ImagePath.radom(0),
      'phone': phone,
      'email': email,
    };
  }
}
