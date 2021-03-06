import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:zapiti_desafio/app/app_bloc.dart';
import 'package:zapiti_desafio/app/component/date/select_day.dart';
import 'package:zapiti_desafio/app/component/dialog/dialog_date_time.dart';
import 'package:zapiti_desafio/app/component/dialog/dialog_generic.dart';
import 'package:zapiti_desafio/app/modules/home/modules/chat/chat_page.dart';
import 'package:zapiti_desafio/app/modules/home/modules/chat/widget/chat/chat_perspective.dart';
import 'package:zapiti_desafio/app/utils/string/string_file.dart';
import 'package:zapiti_desafio/app/utils/theme/app_theme_utils.dart';

class DateAppBarCustom extends StatelessWidget {
  var appBloc = Modular.get<AppBloc>();

  DateAppBarCustom();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: StreamBuilder<DateTime>(
            stream: appBloc.dateSelectedSubject,
            builder: (context, snapshot) => Container(
                  height: 56.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: AppThemeUtils.whiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.zero,
                      topRight: Radius.zero,
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.circular(28.0),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          child: selectDay(
                              context: context,
                              text: "D",
                              selected: selectedDate(snapshot.data, "domingo"),
                              dateTime: snapshot.data)),
                      Expanded(
                          child: selectDay(
                              context: context,
                              text: "S",
                              selected: selectedDate(snapshot.data, "segunda"),
                              dateTime: snapshot.data)),
                      Expanded(
                          child: selectDay(
                              context: context,
                              text: "T",
                              selected: selectedDate(snapshot.data, "terça"),
                              dateTime: snapshot.data)),
                      Expanded(
                          child: selectDay(
                              context: context,
                              text: "Q",
                              selected: selectedDate(snapshot.data, "quarta"),
                              dateTime: snapshot.data)),
                      Expanded(
                          child: selectDay(
                              context: context,
                              text: "Q",
                              selected: selectedDate(snapshot.data, "quinta"),
                              dateTime: snapshot.data)),      Expanded(
                          child: selectDay(
                              context: context,
                              text: "S",
                              selected: selectedDate(snapshot.data, "Sexta"),
                              dateTime: snapshot.data)),
                      Expanded(
                          child: selectDay(
                              context: context,
                              text: "S",
                              selected: selectedDate(snapshot.data, "sábado"),
                              dateTime: snapshot.data)),
                      Expanded(
                          child: InkWell(
                              onTap: () {
                                showGenericDialog(
                                    context: context,
                                    title: "ALOOOO!",
                                    description: "Este e um aplicativo de exemplo simples ainda temos muito a construir em hehehe (^_-)≡☆",
                                    iconData: Icons.call,
                                    positiveCallback: () {
                                      FocusScope.of(context).requestFocus(FocusNode());
                                    },
                                    positiveText: StringFile.ok);
                              },
                              child: Container(
                                width: 120,
                                height: 120,
                                child: Icon(Icons.error_outline),
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppThemeUtils.colorSecundary),
                              )))
                    ],
                  ),
                )));
  }
}

bool selectedDate(DateTime dateTime, String text) {
  String day = DateFormat('EEEE', 'pt_BR')
      .format(
    dateTime ?? DateTime.now(),
  ).toLowerCase();
  var isEquals = day
      .toLowerCase()
      .contains(text.toLowerCase());

  return isEquals;
}
