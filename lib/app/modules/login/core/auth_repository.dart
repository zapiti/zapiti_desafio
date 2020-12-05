import 'dart:async';

import 'package:zapiti_desafio/app/configuration/app_configuration.dart';
import 'package:zapiti_desafio/app/core/auth/auth_repository_interface.dart';
import 'package:zapiti_desafio/app/models/page/response_paginated.dart';

class AuthRepository implements IAuthRepository {
  static const SERVICELOGIN = "/api/login/doLogin";

  @override
  Future<ResponsePaginated> getLogin({String username, String password}) async {
    if (AppConfiguration.isMockDevTest) {
      return ResponsePaginated();
    } else {
      return ResponsePaginated();
    }
  }

  @override
  Future<ResponsePaginated> getLogout() async {
    return ResponsePaginated();
  }
}
