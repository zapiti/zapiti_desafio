import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:zapiti_desafio/app/component/dialog/dialog_generic.dart';
import 'package:zapiti_desafio/app/modules/home/modules/init/model/user.dart';
import 'package:zapiti_desafio/app/modules/login/login_bloc.dart';
import 'package:zapiti_desafio/app/utils/string/string_file.dart';
import 'package:zapiti_desafio/app/utils/utils.dart';

import '../../../../app_bloc.dart';

class ProfileBloc extends Disposable {
  var signupNameController = TextEditingController();

  var signupPhoneController = MaskedTextController(mask: "(00) 00000-0000");

  var signupEmailController = TextEditingController();

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {}

  void getUserInfo() {
    var appBloc = Modular.get<AppBloc>();

    FirebaseFirestore db = GetIt.I.get<FirebaseFirestore>();
    String uid = appBloc.getCurrentUserValue()?.uid.toString();
    try {
      db.collection('users').doc(uid).get().then((data) {
        var item = data.data();
        if (item != null) {
          var user = MyUser.fromMap(item);
          var currentUser = appBloc.currentUserSubject.stream.value ?? MyUser();
          currentUser.name = user.name;
          currentUser.phone = user.phone;
          currentUser.email = user.email;
          currentUser.profile_picture = user.profile_picture;
          appBloc.currentUserSubject.sink.add(currentUser);

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
    var user = appBloc.getCurrentUserValue();
    if (user.uid == null) {
      showGenericDialog(
          context: context,
          title: StringFile.ixi,
          description: StringFile.precisaLogaEditar,
          iconData: Icons.eco_rounded,
          negativeCallback: () {},
          positiveCallback: () {
            Modular.get<LoginBloc>().getLogout(goToLogin: true);
          },
          positiveText: StringFile.logarAgora);
    } else {
      FirebaseFirestore db = GetIt.I.get<FirebaseFirestore>();
      String uid = appBloc.getCurrentUserValue()?.uid.toString();
      try {
        var user = appBloc.currentUserSubject.stream.value ?? MyUser();
        user.name = signupNameController.text;
        user.phone = Utils.removeMask(signupPhoneController.text);
        user.email = signupEmailController.text;

        db.collection('users').doc(uid).set(user.toMap()).then((value) {
          showGenericDialog(
              context: context,
              title: "Conseguimos",
              description: "Dados atualizados com sucesso!!!",
              iconData: Icons.supervisor_account,
              positiveCallback: () {
                appBloc.currentUserSubject.sink.add(user);
                FocusScope.of(context).requestFocus(FocusNode());
              },
              positiveText: StringFile.ok);
        });
      } catch (e) {
        print(e);
      }
    }
  }
}
