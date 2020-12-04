import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flux_validator_dart/flux_validator_dart.dart';
import 'package:get_it/get_it.dart';
import 'package:zapiti_desafio/app/component/dialog/dialog_generic.dart';
import 'package:zapiti_desafio/app/models/user_entity.dart';
import 'package:zapiti_desafio/app/routes/constants_routes.dart';
import 'package:zapiti_desafio/app/utils/preferences/cd_preferences.dart';
import 'package:zapiti_desafio/app/utils/preferences/local_data_store.dart';
import 'package:zapiti_desafio/app/utils/string/string_file.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zapiti_desafio/app/utils/utils.dart';

import '../../app_bloc.dart';
import 'model/users.dart';

class LoginBloc extends Disposable {
  final _bloc = Modular.get<AppBloc>();
  var emailController = TextEditingController();

  var passController = TextEditingController();

  var isLoad = BehaviorSubject<bool>.seeded(false);

  var showPass = BehaviorSubject<bool>.seeded(true);

  var nameController = TextEditingController();

  var passConfirmController = TextEditingController();

  var showPassConfirm = BehaviorSubject<bool>.seeded(true);

  var dateNscController = TextEditingController();

  var alturaControler = TextEditingController();

  var sexoController = TextEditingController();

  var erroEmailView = BehaviorSubject<String>();
  var erroPassView = BehaviorSubject<String>();

  var erroNameView = BehaviorSubject<String>();

  Future<void> signup(BuildContext context) async {
    FirebaseAuth auth = GetIt.I.get<FirebaseAuth>();

    if (nameController.text.isEmpty) {
      erroNameView.sink.add("nome não pode ser vazio");
    } else if (emailController.text.isEmpty) {
      erroEmailView.sink.add("E-mail não pode ser vazio");
    } else if (Validator.email(emailController.text)) {
      erroEmailView.sink.add("E-mail está com formato inválido");
    } else if (passController.text.isEmpty) {
      erroPassView.sink.add("Senha não pode ser vazia");
    } else if (!Utils.isCharacter(passController.text) &&
        !Utils.isUppercase(passController.text) &&
        !Utils.isMinLetter(passController.text, 6)) {
      var listError = [];
      if (!Utils.isCharacter(passController.text)) {
        listError.add("caracter especial");
      }
      if (!Utils.isMinLetter(passController.text, 6)) {
        listError.add("mínimo 6 digitos");
      }
      if (!Utils.isUppercase(passController.text)) {
        listError.add("letra maiuscula");
      }

      erroPassView.sink.add("adicione ${listError.join(",")}");
    } else {
      isLoad.sink.add(true);
      try {
        var result = await auth.createUserWithEmailAndPassword(
            email: emailController.text, password: passController.text);
        final user = result.user;
        await Users(uid: user.uid)
            .updateUserData(nameController.text, emailController.text);
        user.sendEmailVerification();
        isLoad.sink.add(false);
        Modular.to.pushReplacementNamed(ConstantsRoutes.HOMEPAGE);
      } catch (e) {
        print(e.message);
        isLoad.sink.add(false);
        showGenericDialog(
            context: context,
            title: StringFile.atencao,
            description: "Falha ao se registrar",
            iconData: Icons.error_outline,
            positiveCallback: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            positiveText: StringFile.ok);
      }
    }
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    isLoad.drain();
    showPass.drain();
    erroNameView.drain();
    showPassConfirm.drain();
    erroEmailView.drain();
    erroPassView.drain();
  }

  void getLogout() {
    FirebaseAuth auth = GetIt.I.get<FirebaseAuth>();
    _bloc.anonimoUserSubject.sink.add(false);
    auth.signOut().then((value) {
      storage.clear().then((value) {
        Modular.to.pushReplacementNamed(ConstantsRoutes.LOGIN);
      });
    });
  }

  void getLogin(BuildContext context) async {
    if (emailController.text.isEmpty) {
      erroEmailView.sink.add("E-mail não pode ser vazio");
    } else if (Validator.email(emailController.text)) {
      erroEmailView.sink.add("E-mail está com formato inválido");
    }else{
      isLoad.sink.add(true);
      FirebaseAuth auth = GetIt.I.get<FirebaseAuth>();
      try {
        var result = await auth.signInWithEmailAndPassword(
            email: emailController.text, password: passController.text);
        final user = result.user;
        isLoad.sink.add(false);
        Modular.to.pushReplacementNamed(ConstantsRoutes.HOMEPAGE);
      } catch (e) {
        print(e.message);
        isLoad.sink.add(false);
        showGenericDialog(
            context: context,
            title: StringFile.atencao,
            description: "Login ou senha inválido",
            iconData: Icons.error_outline,
            positiveCallback: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            positiveText: StringFile.ok);
      }
    }

  }
}
