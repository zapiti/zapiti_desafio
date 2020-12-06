import 'package:flutter_modular/flutter_modular.dart';
import 'package:zapiti_desafio/app/modules/home/modules/init/model/news.dart';

import '../app_bloc.dart';

class Utils {
  static String truncate(String texto, int max) {
    return texto.length <= max ? texto : texto.substring(0, max) + "...";
  }

  static bool isMinLetter(String text, int i) {
    return text.length > i;
  }

  static bool isUppercase(String text) {
    return text.contains(new RegExp(r'[A-Z]'));
  }

  static bool isCharacter(String text) {
    return text.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  static bool hasDigits(String text) {
    return text.contains(new RegExp(r'[0-9]'));
  }

  static bool isMyNews(News news) {
    var appBloc = Modular.get<AppBloc>();
    if (news.user.uid == null ||
        appBloc.getCurrentUserValue()?.uid?.toString() == null) {
      return false;
    } else {
      if (news.user?.uid == appBloc.getCurrentUserValue()?.uid.toString()) {
        return true;
      }
    }
    return false;
  }

  static String removeMask(String text) {
    var _phoneUnMask = text?.replaceAll('(', '');
    _phoneUnMask = _phoneUnMask?.replaceAll(')', '');
    _phoneUnMask = _phoneUnMask?.replaceAll(' ', '');
    _phoneUnMask = _phoneUnMask?.replaceAll('-', '');
    _phoneUnMask = _phoneUnMask?.replaceAll('.', '');
    _phoneUnMask = _phoneUnMask?.replaceAll(' ', '');
    return _phoneUnMask;
  }
}
