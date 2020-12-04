import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zapiti_desafio/app/core/util/color_util.dart';
import 'package:zapiti_desafio/app/modules/home/modules/profile/model/profile.dart';
import 'package:zapiti_desafio/app/modules/home/modules/profile/model/profile_notification.dart';
import 'package:zapiti_desafio/app/modules/home/modules/profile/widget/profile_notification_widget.dart';
import 'package:zapiti_desafio/app/modules/home/modules/profile/widget/profile_preferences_widget.dart';
import 'package:zapiti_desafio/app/modules/home/modules/profile/widget/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  final String title;

  const ProfilePage({Key key, this.title = "Profile"}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {

    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: ColorUtil.primaryColor,
          middle: Text(
            "PERFIL",
            style: TextStyle(color: Colors.white),
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([

              ]),
            )
          ],
        ));
  }
}
