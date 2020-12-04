import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zapiti_desafio/app/component/dialog/dialog_generic_textfield.dart';

class HomeBloc extends Disposable {
  var selectedMenu = BehaviorSubject<int>.seeded(0);

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    selectedMenu.drain();
  }

  void creatPost(context) {
    var controllPost = TextEditingController();

    showTextFieldGenericDialog(
        context: context,
        title: "Criar postagem",
        inputFormatters: [LengthLimitingTextInputFormatter(280)],
        minSize: 50,lines: 4,
        erroText: "Escreva entre 30 e 280 caracteres.",
        controller: controllPost,positiveText: "Enviar",
        positiveCallback: () {});
  }
}
