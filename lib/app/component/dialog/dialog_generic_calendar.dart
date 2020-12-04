import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:zapiti_desafio/app/app_bloc.dart';
import 'package:zapiti_desafio/app/component/simple/line_view_widget.dart';
import 'package:zapiti_desafio/app/utils/string/string_file.dart';
import 'package:zapiti_desafio/app/utils/theme/app_theme_utils.dart';
import 'package:table_calendar/table_calendar.dart';

void showGenericDialogCalendar({
  BuildContext context,
  DateTime selectedDay,
}) {
  // FocusScope.of(context).requestFocus(FocusNode());
  showDialog(
      context: context,barrierDismissible: true,
      builder: (BuildContext context) => _DialogGeneric(
            selectedDay: selectedDay,
          ));
}

// Simple TableCalendar configuration (using Styles)
Widget _buildTableCalendar(BuildContext context, DateTime selectedDay) {
  var appBloc = Modular.get<AppBloc>();
  return TableCalendar(
    calendarController: CalendarController(),
    startingDayOfWeek: StartingDayOfWeek.sunday,
    availableCalendarFormats: const {
      CalendarFormat.week: 'Semana',
      CalendarFormat.month: 'Mês',
    },
    locale: 'pt_BR',
    initialCalendarFormat: CalendarFormat.week,
    initialSelectedDay: selectedDay,
    headerStyle: HeaderStyle(
        titleTextBuilder: (date, _) => DateFormat('MMMM', 'pt_BR').format(
              date ?? DateTime.now(),
            )),
    endDay: DateTime.now().add(Duration(days: 15)),
    startDay: DateTime.now().add(Duration(days: -15)),
    calendarStyle: CalendarStyle(
      selectedColor: AppThemeUtils.colorPrimary,
      todayColor: AppThemeUtils.colorSecundary,

      outsideDaysVisible: true,
    ),
    onDaySelected: (day, date, _) {
      Navigator.of(context).pop();
      appBloc.dateSelectedSubject.sink.add(day);
    },
  );
}

class _DialogGeneric extends StatelessWidget {
  DateTime selectedDay;

  _DialogGeneric({this.selectedDay});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pop(context);
      },
        child:  SingleChildScrollView(
      child: Container(
          width: 800,
          margin: EdgeInsets.only(right: 20, top: 56),
          child: Material(
              color: Colors.transparent,
              child: Container(
                  child: ListBody(children: <Widget>[
                Container(
                    padding: EdgeInsets.only(top: 0, bottom: 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.zero,
                          topRight: Radius.zero,
                          bottomLeft: Radius.zero,
                          bottomRight: Radius.circular(28.0),
                        ),
                        border: Border.all(
                          color: Colors.transparent,
                        )),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 0, bottom: 8),
                          decoration: BoxDecoration(
                              color: AppThemeUtils.whiteColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.zero,
                                topRight: Radius.zero,
                                bottomLeft: Radius.zero,
                                bottomRight: Radius.circular(28.0),
                              ),
                              border: Border.all(
                                color: Colors.transparent,
                              )),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                          child: _buildTableCalendar(
                                              context, selectedDay))
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ],
                    )),
              ])))),
    ));
  }
}

class WidgetDialogGeneric extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Widget description;
  final VoidCallback positiveCallback;
  final VoidCallback negativeCallback;
  final String positiveText;
  final String negativeText;
  final Color color;
  final Color topColor;
  final String subtitle;
  final bool hideSubTitle;
  final bool isLight;
  final bool containsPop;
  final String imagePath;

  WidgetDialogGeneric(
      {this.iconData,
      this.title,
      this.topColor,
      this.description,
      this.positiveCallback,
      this.negativeCallback,
      this.positiveText,
      this.negativeText,
      this.color,
      this.isLight = true,
      this.containsPop = true,
      this.subtitle,
      this.hideSubTitle = true,
      this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
          child: Container(
              width: MediaQuery.of(context).size.width > 450
                  ? 400
                  : MediaQuery.of(context).size.width * 0.8,
              child: Material(
                  color: Colors.transparent,
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.transparent,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: ListBody(children: <Widget>[
                        Container(
                            padding: EdgeInsets.only(top: 0, bottom: 0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              border: Border.all(color: Colors.white, width: 0),
                              shape: BoxShape.rectangle,
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                    decoration: BoxDecoration(
                                        color: AppThemeUtils.colorPrimary,
                                        border: Border.all(
                                          color: Colors.transparent,
                                        ),
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            topLeft: Radius.circular(20))),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 5, bottom: 5, left: 20),
                                          child: imagePath != null
                                              ? Image.asset(
                                                  imagePath,
                                                  height: 60,
                                                  width: 60,
                                                )
                                              : Icon(
                                                  iconData,
                                                  color: color ??
                                                      AppThemeUtils.whiteColor,
                                                  size: 30,
                                                ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: Container(
                                                margin: EdgeInsets.only(
                                                    top: 10,
                                                    bottom: 10,
                                                    right: 10),
                                                child: AutoSizeText(
                                                  title,
                                                  minFontSize: 10,
                                                  maxLines: 1,
                                                  style:
                                                      AppThemeUtils.normalSize(
                                                          color: color ??
                                                              AppThemeUtils
                                                                  .whiteColor,
                                                          fontSize: 22),
                                                ))),
                                      ],
                                    )),
                                lineViewWidget(),
                                Container(
                                  padding: EdgeInsets.only(top: 20, bottom: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    border: Border.all(
                                        color: Colors.white, width: 1),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 0),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Flexible(child: description),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            top: 20, bottom: 10),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            negativeCallback == null
                                                ? SizedBox()
                                                : Expanded(
                                                    child: Center(
                                                    child: Container(
                                                        width: 200,
                                                        margin: EdgeInsets.only(
                                                            right: 10,
                                                            left: 10,
                                                            bottom: 10,
                                                            top: 5),
                                                        child: RaisedButton(
                                                          color: isLight
                                                              ? Colors
                                                                  .transparent
                                                              : AppThemeUtils
                                                                  .colorError,
                                                          elevation: 0,
                                                          onPressed: () {
                                                            negativeCallback();
                                                            if (containsPop) {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            }
                                                          },
                                                          child: AutoSizeText(
                                                            negativeText ??
                                                                StringFile.nao,
                                                            maxLines: 1,
                                                            minFontSize: 8,
                                                            style: AppThemeUtils
                                                                .normalBoldSize(
                                                              color: isLight
                                                                  ? AppThemeUtils
                                                                      .colorPrimary
                                                                  : AppThemeUtils
                                                                      .whiteColor,
                                                            ),
                                                          ),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(Radius
                                                                          .circular(
                                                                              5)),
                                                              side: BorderSide(
                                                                  color: isLight
                                                                      ? Colors
                                                                          .transparent
                                                                      : AppThemeUtils
                                                                          .colorError,
                                                                  width: 1)),
                                                        )),
                                                  )),
                                            positiveCallback == null
                                                ? SizedBox()
                                                : Expanded(
                                                    child: Center(
                                                    child: Container(
                                                        width: 200,
                                                        margin: EdgeInsets.only(
                                                            right: 10,
                                                            left: 10,
                                                            bottom: 10,
                                                            top: 5),
                                                        child: RaisedButton(
                                                          color: AppThemeUtils
                                                              .colorPrimary,
                                                          elevation: 0,
                                                          onPressed: () {
                                                            positiveCallback();
                                                            if (containsPop) {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            }
                                                          },
                                                          child: Container(
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                horizontal: 0,
                                                              ),
                                                              child:
                                                                  AutoSizeText(
                                                                positiveText ??
                                                                    StringFile
                                                                        .sim,
                                                                maxLines: 1,
                                                                minFontSize: 8,
                                                                style: AppThemeUtils
                                                                    .normalBoldSize(
                                                                  color: AppThemeUtils
                                                                      .whiteColor,
                                                                ),
                                                              )),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          5))),
                                                        )),
                                                  )),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ]))))),
    );
  }
}
