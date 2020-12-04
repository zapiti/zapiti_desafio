import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zapiti_desafio/app/utils/theme/app_theme_utils.dart';

class AppBarCustom extends StatelessWidget {
  String title;

  AppBarCustom(this.title);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:  Container(
      height: 56.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: AppThemeUtils.colorPrimary,
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
              width: 70,

              child: Center(
                  child: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.arrow_back_ios_rounded,
                    color: AppThemeUtils.colorPrimary),
                mini: true,
                backgroundColor: AppThemeUtils.whiteColor,
              ))),
          Container(
              width: MediaQuery.of(context).size.width,
              height: 56.0,
              child: Center(
                  child: Text(
                title,
                textAlign: TextAlign.center,
                style: AppThemeUtils.normalBoldSize(
                    color: AppThemeUtils.whiteColor, fontSize: 18),
              )))
        ],
      ),
    ));
  }
}
