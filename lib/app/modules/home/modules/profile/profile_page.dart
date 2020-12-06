import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zapiti_desafio/app/app_bloc.dart';
import 'package:zapiti_desafio/app/component/appbar/app_bar_custom.dart';
import 'package:zapiti_desafio/app/component/state_view/empty_view_mobile.dart';
import 'package:zapiti_desafio/app/component/textfield/custom_grey_textfield.dart';
import 'package:zapiti_desafio/app/image/image_path.dart';
import 'package:zapiti_desafio/app/modules/home/modules/init/model/user.dart';

import 'package:zapiti_desafio/app/modules/home/modules/profile/profile_bloc.dart';
import 'package:zapiti_desafio/app/modules/login/login_bloc.dart';
import 'package:zapiti_desafio/app/utils/string/string_file.dart';

class ProfilePage extends StatefulWidget {
  final String title;

  const ProfilePage({Key key, this.title = "Profile"}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var bloc = Modular.get<ProfileBloc>();
  var appBloc = Modular.get<AppBloc>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        AppBarCustom("Perfil", isChat: true),
        Expanded(
          child: SingleChildScrollView(
            child: StreamBuilder<MyUser>(
                stream: appBloc.currentUserSubject,
                builder: (context, snapshotUser) =>
                    snapshotUser.data?.uid == null
                        ?  emptyViewMobile(context,tentarNovamente: (){
                      Modular.get<LoginBloc>().getLogout(goToLogin: true);
                    },buttomText: StringFile.logarAgora,emptyMessage: StringFile.naoAnadaPorAqui)
                        : Container(
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 50,
                                ),
                                CircleAvatar(
                                    radius: 100,
                                    child: ClipOval(
                                        child: Image.network(
                                      ImagePath.radom(2),
                                    ))),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 20.0,
                                      bottom: 20.0,
                                      left: 25.0,
                                      right: 25.0),
                                  child: CustomGreyTextField(
                                    controller: bloc.signupNameController,
                                    keyboardType: TextInputType.text,
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.black,
                                    ),
                                    labelText: "Nome",
                                  ),
                                ),
                                Container(
                                  width: 250.0,
                                  height: 1.0,
                                  color: Colors.grey[400],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 20.0,
                                      bottom: 20.0,
                                      left: 25.0,
                                      right: 25.0),
                                  child: CustomGreyTextField(
                                    controller: bloc.signupPhoneController,
                                    keyboardType: TextInputType.number,
                                    prefixIcon:
                                        Icon(Icons.phone, color: Colors.black),
                                    labelText: "Celular",
                                  ),
                                ),
                                Container(
                                  width: 250.0,
                                  height: 1.0,
                                  color: Colors.grey[400],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 20.0,
                                      bottom: 20.0,
                                      left: 25.0,
                                      right: 25.0),
                                  child: CustomGreyTextField(
                                    controller: bloc.signupEmailController,
                                    keyboardType: TextInputType.emailAddress,
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Colors.black,
                                    ),
                                    labelText: "E-mail",
                                  ),
                                ),
                                Container(
                                  width: 250.0,
                                  height: 1.0,
                                  color: Colors.grey[400],
                                ),
                                Container(
                                  width: 250.0,
                                  height: 1.0,
                                  color: Colors.grey[400],
                                ),
                              ],
                            ),
                          )),
          ),
        ),
      ],
    ));
  }
}
