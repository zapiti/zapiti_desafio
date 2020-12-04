
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zapiti_desafio/app/component/appbar/date_app_bar_custtom.dart';


class InitMobilePage extends StatefulWidget {
  @override
  _InitMobilePageState createState() => _InitMobilePageState();
}

class _InitMobilePageState extends State<InitMobilePage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          DateAppBarCustom(),

        ],
      ),
    );
  }
}
