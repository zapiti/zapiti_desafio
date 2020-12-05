import 'package:zapiti_desafio/app/models/page/response_paginated.dart';

abstract class IAuthRepository {
  Future<ResponsePaginated> getLogin({String username, String password});

  Future<ResponsePaginated>  getLogout();
}
