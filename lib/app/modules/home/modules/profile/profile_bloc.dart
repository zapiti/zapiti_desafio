import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:zapiti_desafio/app/component/dialog/dialog_generic.dart';
import 'package:zapiti_desafio/app/modules/home/modules/init/model/user.dart';
import 'package:zapiti_desafio/app/utils/string/string_file.dart';

import '../../../../app_bloc.dart';

class ProfileBloc extends Disposable {
  var signupNameController = TextEditingController();

  var signupPhoneController = TextEditingController();

  var signupEmailController = TextEditingController();

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {}

  void getUserInfo() {
    var appBloc = Modular.get<AppBloc>();

    FirebaseFirestore db = GetIt.I.get<FirebaseFirestore>();
    String uid = appBloc.getCurrentUserValue().uid.toString();
    try {
      db.collection('users').doc(uid).get().then((data) {
        var item = data.data();
        if (item != null) {
          var user = MyUser.fromMap(item);
          var currentUser = appBloc.currentUserSubject.stream.value;

          signupNameController.text = user.name;
          signupPhoneController.text = user.phone;
          signupEmailController.text = user.email;
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void editProfile(BuildContext context) {
    var appBloc = Modular.get<AppBloc>();

    FirebaseFirestore db = GetIt.I.get<FirebaseFirestore>();
    String uid = appBloc.getCurrentUserValue().uid.toString();
    try {
      var user = MyUser();
      user.name = signupNameController.text;
      user.phone = signupPhoneController.text;
      user.email = signupEmailController.text;
      db.collection('users').doc(uid).set(user.toMap()).then((value) {
        showGenericDialog(
            context: context,
            title: "Conseguimos",
            description: "Dados atualizados com sucesso!!!",
            iconData: Icons.supervisor_account,
            positiveCallback: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            positiveText: StringFile.ok);
      });
    } catch (e) {
      print(e);
    }
  }
}
