import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:zapiti_desafio/app/component/appbar/app_bar_custom.dart';
import 'package:zapiti_desafio/app/component/load/load_elements.dart';
import 'package:zapiti_desafio/app/component/textfield/custom_grey_textfield.dart';
import 'package:zapiti_desafio/app/routes/constants_routes.dart';
import 'package:zapiti_desafio/app/utils/theme/app_theme_utils.dart';

import '../../login_bloc.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final bloc = Modular.get<LoginBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
        children: <Widget>[
          AppBarCustom("Login"),
          Expanded(
              child: SingleChildScrollView(
            child: StreamBuilder(
                stream: bloc.isLoad,
                initialData: false,
                builder: (context, snapshot) {
                  var _isLoadRequest = snapshot.data;
                  return Column(
                    children: [
                   StreamBuilder<String>(stream: bloc.erroEmailView,builder: (context,snapshotEmail)=>   Container(
                          margin: EdgeInsets.only(
                              right: 30, left: 30, top: 56, bottom: 20),
                          child:  CustomGreyTextField(
                            enabled: !_isLoadRequest,
                            obscureText:false,
                            labelText: "E-mail",errorText:snapshotEmail.data,onChanged:(text){
                            bloc.erroEmailView.sink.add(null);
                          },
                            controller: bloc.emailController,
                            prefixIcon: Icon(
                              Icons.person,
                              size: 18,
                              color: AppThemeUtils.colorPrimary,
                            ),
                          ))),
                      StreamBuilder<String>(stream: bloc.erroPassView,builder: (context,snapshotPass)=>    Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          child: StreamBuilder<bool>(
                              stream: bloc.showPass.stream,
                              initialData: false,
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshotHide) {
                                return CustomGreyTextField(
                                  enabled: !_isLoadRequest,
                                  obscureText: snapshot.data,
                                  labelText: "Senha",errorText:snapshotPass.data,onChanged:(text){
                                  bloc.erroPassView.sink.add(null);
                                },
                                  controller: bloc.passController,
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    size: 18,
                                    color: AppThemeUtils.colorPrimary,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      snapshotHide.data
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: AppThemeUtils.colorPrimaryDark,
                                    ),
                                    onPressed: () {
                                      bloc.showPass.sink.add(!snapshotHide.data);
                                    },
                                  ),
                                );
                              }))),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          alignment: Alignment.centerRight,
                          child: FlatButton(
                              onPressed: () {
                                Modular.to.pushNamed(ConstantsRoutes.RECOVERYPASS);
                              },
                              child: Text(
                                "Esqueceu sua senha?",
                                style: AppThemeUtils.smallSize(),
                              ))),
                      _isLoadRequest
                          ? loadElements(context)
                          :    Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        child: SizedBox(
                          width: 150,height: 45,
                          child: RaisedButton(
                            padding: EdgeInsets.all(5),
                            color: AppThemeUtils.colorPrimary80,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              "Entrar",
                              style: AppThemeUtils.normalSize(
                                  color: AppThemeUtils.whiteColor),
                            ),
                            onPressed: () {
                              bloc.getLogin(context);
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ))
        ],
      ),
    );
  }
}
