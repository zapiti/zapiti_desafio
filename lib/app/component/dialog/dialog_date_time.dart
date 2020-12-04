import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';


class DialogDateTime {


  static Future<DateTime> selectDate(BuildContext context,DateTime dateInit,
      {bool isTime = false}) async {
    DateTime datePicked;
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate:dateInit,
        firstDate: dateInit.add(Duration(days:- 30)),
        lastDate: dateInit.add(Duration(days: 30)));

    datePicked = picked;

    if (picked == null) {
      return picked;
    }

    if (isTime) {
      final TimeOfDay pickedTime =
      await showTimePicker(context: context, initialTime: TimeOfDay.now());
      if (pickedTime != null) {
        datePicked = DateTime(picked.year, picked.month, picked.day,
            pickedTime.hour, pickedTime.minute);
      }
    }

    return datePicked;
  }

  static selectDateNasc(BuildContext context, Function(DateTime) onDate) async {
    var date = DateTime.now();
    var newDate = new DateTime(date.year - 18, date.month , date.day);
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(1900, 3, 5),
        maxTime: DateTime.now(), onChanged: (date) {
      // onDate(date);
    }, onConfirm: (date) {
      onDate(date);
    },
        currentTime: newDate,
        locale: LocaleType.pt);
  }
}
