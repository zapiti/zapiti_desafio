import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:zapiti_desafio/app/component/dialog/dialog_generic.dart';
import 'package:zapiti_desafio/app/modules/home/modules/chat/chat_page.dart';

import 'package:zapiti_desafio/app/modules/login/login_bloc.dart';

import 'package:zapiti_desafio/app/utils/string/string_file.dart';
import 'package:zapiti_desafio/app/utils/theme/app_theme_utils.dart';

import '../../app_bloc.dart';

class AppBarCustom extends StatelessWidget {
  String title;
  bool isChat = false;
  final _appBloc = Modular.get<AppBloc>();

  AppBarCustom(this.title, {this.isChat = false});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      height: 56.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: isChat ? AppThemeUtils.colorPrimary : AppThemeUtils.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.zero,
          topRight: Radius.zero,
          bottomLeft: Radius.zero,
          bottomRight: Radius.circular(28.0),
        ),
      ),
      child: Stack(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: 56.0,
              child: Center(
                  child: Text(
                title,
                textAlign: TextAlign.center,
                style: AppThemeUtils.normalBoldSize(
                    color: !isChat
                        ? AppThemeUtils.colorPrimary
                        : AppThemeUtils.whiteColor,
                    fontSize: 18),
              ))),
          Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                  onTap: () {
                    if (isChat) {
                      var user = _appBloc.getCurrentUserValue();
                      if (user.uid == null) {
                        showGenericDialog(
                            context: context,
                            title: StringFile.ixi,
                            description: StringFile.precisaLoga,
                            iconData: Icons.hail,
                            negativeCallback: () {},
                            positiveCallback: () {
                              Modular.get<LoginBloc>()
                                  .getLogout(goToLogin: true);
                            },
                            positiveText: StringFile.logarAgora);
                      } else {
                        Modular.to.push(MaterialPageRoute(
                            builder: (context) => ChatPage()));
                      }
                    } else {
                      Modular.to.pop();
                    }
                  },
                  child: Container(
                    width: 65,
                    height: 120,
                    child: Icon(
                        isChat ? Icons.chat : Icons.arrow_back_ios_rounded),
                    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isChat
                            ? AppThemeUtils.colorSecundary
                            : AppThemeUtils.colorPrimary),
                  )))
        ],
      ),
    ));
  }
}
