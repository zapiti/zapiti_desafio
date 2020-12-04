import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zapiti_desafio/app/core/util/color_util.dart';
import 'package:zapiti_desafio/app/modules/home/modules/profile/model/profile.dart';

class ProfileWidget extends StatelessWidget {
  final Profile profile;

  ProfileWidget({@required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Material(
                child: Image.network(
                  profile.imageProfileUrl,
                  height: 60,
                  width: 60,
                ),
                elevation: 18,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                clipBehavior: Clip.antiAlias,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile.name,
                    style: TextStyle(
                        color: ColorUtil.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Text(
                      "Editar perfil",
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    onPressed: () {
                      print("Ir pra editar perfil");
                    },
                  )
                ],
              ),
            ),
            Image.network(
              profile.imageCompanyUrl,
              height: 120,
              width: 120,
            ),
          ],
        ),
        _getText(field: "Nome", value: profile.name),
        _getText(field: "Matricula", value: profile.registration),
        _getText(field: "Empresa", value: profile.company),
        _getText(field: "Benefício", value: profile.benefit.toString()),
        _getText(field: "E-mail corporativo", value: profile.email),
        Row(
          children: [
            _getSocialMedia(
                socialMediaImageUrl:
                    "https://i1.wp.com/oficinadapalavraplic.com.br/wp-content/uploads/2017/07/facebook.png",
                value: profile.facebook),
            _getSocialMedia(
                socialMediaImageUrl:
                    "https://agencia3graus.com.br/wp-content/uploads/2018/01/instagram.png",
                value: profile.instagram)
          ],
        ),
        Container(
          padding: EdgeInsets.only(bottom: 6),
        )
      ],
    );
  }

  Widget _getText({@required String field, @required String value}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        "$field: $value",
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  Widget _getSocialMedia(
      {@required String socialMediaImageUrl, @required String value}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
      child: Row(
        children: [
          Image.network(socialMediaImageUrl, height: 20, width: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              value,
              style: TextStyle(color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
