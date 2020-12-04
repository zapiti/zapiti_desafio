import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:zapiti_desafio/app/image/image_logo_widget.dart';
import 'package:zapiti_desafio/app/modules/login/login_bloc.dart';
import 'package:zapiti_desafio/app/routes/constants_routes.dart';
import 'package:zapiti_desafio/app/utils/theme/app_theme_utils.dart';

import '../../app_bloc.dart';

class LoginPage extends StatefulWidget {
  final String title;

  const LoginPage({Key key, this.title = "Login"}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var bloc = Modular.get<LoginBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemeUtils.colorPrimary,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                child: GetLogoIcon(),
                padding: EdgeInsets.only(bottom: 15),
              ),
              Text(
                "Olá pessoa!",
                style: AppThemeUtils.normalSize(fontSize: 30),
              ),
              Text(
                "Entre para acessar o desafio criado por mim para validar algumas coisinhas!",
                style: AppThemeUtils.normalSize(),
                textAlign: TextAlign.center,
              ),
              Padding(
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
                     Modular.to.pushNamed(ConstantsRoutes.LOGIN_PAGE);
                    },
                  ),
                ),
              ),
              Text(
                "ainda não possui conta?",
                style: AppThemeUtils.smallSize(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5,bottom: 20),
                child: SizedBox(
                  width: 150,height: 45,
                  child: RaisedButton(
                    padding: EdgeInsets.all(5),
                    color: AppThemeUtils.colorPrimary80,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      "Cadastrar",
                      style: AppThemeUtils.normalSize(
                          color: AppThemeUtils.whiteColor),
                    ),
                    onPressed: () {
                      Modular.to.pushNamed(ConstantsRoutes.REGISTRE_PAGE);
                    },
                  ),
                ),
              ),   Text(
                "não quer criar uma conta?",
                style: AppThemeUtils.smallSize(fontSize: 10),
              ),
              Padding(
                padding: EdgeInsets.only(top: 0),
                child: SizedBox(

                  child: FlatButton(
                    padding: EdgeInsets.all(5),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      "Acessar anônimo",
                      style: AppThemeUtils.normalSize(
                          color: AppThemeUtils.whiteColor),
                    ),
                    onPressed: () {
                      var appBloc = Modular.get<AppBloc>();
                      appBloc.anonimoUserSubject.sink.add(true);
                      Modular.to.pushNamed(ConstantsRoutes.HOMEPAGE);
                    },
                  ),
                ),
              )
            ],
          )),
        ),
      ),
    );
  }

  Widget _getField(
      {String title,
      String placeholder,
      IconData icon,
      TextEditingController controller}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            padding: EdgeInsets.only(bottom: 10),
          ),
          CupertinoTextField(
            placeholder: placeholder,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                color: Colors.white),
            prefix: Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
              child: Icon(
                icon,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
