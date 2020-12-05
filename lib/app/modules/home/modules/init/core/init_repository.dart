import 'package:flutter_modular/flutter_modular.dart';
import 'package:zapiti_desafio/app/core/request_core.dart';
import 'package:zapiti_desafio/app/models/page/response_paginated.dart';
import 'package:zapiti_desafio/app/modules/home/modules/init/model/news.dart';

class InitRepository {
  var _requestManager = Modular.get<RequestCore>();

  Future<ResponsePaginated> getListJsonFake() async {
    var response = await _requestManager.requestWithTokenToForm(
        serviceName: "",
        typeRequest: TYPEREQUEST.GET,typeResponse: TYPERESPONSE.LIST,
        namedResponse: "news",
        body: {},
        funcFromMap: (data) => News.fromMap(data) );
    return response;
  }
}
