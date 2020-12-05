import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:zapiti_desafio/app/app_bloc.dart';
import 'package:zapiti_desafio/app/component/dialog/dialog_date_time.dart';
import 'package:zapiti_desafio/app/component/dialog/dialog_generic_calendar.dart';
import 'package:zapiti_desafio/app/utils/theme/app_theme_utils.dart';

Widget selectDay({BuildContext context,String text,bool selected,DateTime dateTime}) {

  return  FlatButton(
      onPressed: () {
        showGenericDialogCalendar(context:context,selectedDay: dateTime);
    // DialogDateTime.selectDate(context,dateTime ?? DateTime.now()).then((value) {
    //   appBloc.dateSelected.sink.add(value);
    // });
  },
  child: Container(

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Container(

      child: Center(child:    AutoSizeText(
            text,textAlign: TextAlign.center,minFontSize: 8,


            style: AppThemeUtils.normalBoldSize(
                color: selected ?AppThemeUtils.colorPrimary: AppThemeUtils.black,
                fontSize: 22),
          ))),
          Container(
            width: 60,
            height: 3,margin: EdgeInsets.only(top: 0),
            color:selected ?AppThemeUtils.colorPrimary: Colors.transparent,
          )
        ],
      )));
}