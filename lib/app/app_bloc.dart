import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zapiti_desafio/app/utils/theme/app_theme_utils.dart';

import 'models/current_user.dart';

class AppBloc extends Disposable {
  final currentUserSubject = BehaviorSubject<CurrentUser>();
  var anonimoUserSubject = BehaviorSubject<bool>.seeded(false);
  var dateSelectedSubject = BehaviorSubject<DateTime>.seeded(DateTime.now());


  CurrentUser getCurrentUserValue() {
    FirebaseAuth auth = GetIt.I.get<FirebaseAuth>();
    final localUser = auth.currentUser;
    CurrentUser user;

    final anonimo = anonimoUserSubject.stream.value;

    if (localUser != null || anonimo) {
      user = CurrentUser();
      user.name = localUser.displayName ?? localUser.email ?? "Anônimo";
      user.id = localUser.uid;
      currentUserSubject.sink.add(user);
    } else {
      user = null;
    }

    return user;
  }

  @override
  void dispose() {
    currentUserSubject.close();

    anonimoUserSubject.close();
    dateSelectedSubject.close();
  }

  Future<CurrentUser> getCurrentUserFutureValue() async {
    FirebaseAuth auth = GetIt.I.get<FirebaseAuth>();
    final localUser = auth.currentUser;
    CurrentUser user;
    final anonimo = anonimoUserSubject.stream.value;

    if (localUser != null || anonimo) {
      user = CurrentUser();
      user.name = localUser.displayName ?? localUser.email ?? "Anônimo";
      user.id = localUser.uid;
      currentUserSubject.sink.add(user);
    } else {
      user = null;
    }

    return user;
  }

  getDefaultTheme() => ThemeData(
      primaryColor: AppThemeUtils.colorPrimary,
      primaryColorLight: AppThemeUtils.colorPrimary,
      buttonColor: AppThemeUtils.colorPrimary,
      iconTheme: IconThemeData(color: AppThemeUtils.whiteColor),
      textTheme: TextTheme(
          bodyText2: TextStyle(
            color: Colors.grey[600],
          ),
          bodyText1: TextStyle(color: Colors.grey[800])),
      unselectedWidgetColor: Colors.grey[300],
      backgroundColor: Colors.grey[100]);
}
