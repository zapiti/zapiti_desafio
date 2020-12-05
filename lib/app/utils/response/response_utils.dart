import 'package:zapiti_desafio/app/core/request_core.dart';
import 'package:zapiti_desafio/app/models/code_response.dart';
import 'package:zapiti_desafio/app/models/page/response_paginated.dart';
import 'package:zapiti_desafio/app/utils/object/object_utils.dart';
import 'package:zapiti_desafio/app/utils/object/object_utils.dart';

class ResponseUtils {
  ///***@response e a resposta do servidor e @funcFromMap converte a resposta do servidor em algo @namedResponse e caso o servidor tenha um nome na resposta
  static List<T> getResponseList<T>(
      CodeResponse response, Function funcFromMap) {
    if (response?.sucess == null) {
      return [];
    }
    List<T> listElementGeneric = [];
    List listContent = response?.sucess?.toList();

    for (var columns in listContent) {
      var prods = funcFromMap(columns);
      listElementGeneric.add(prods);
    }
    return listElementGeneric;
  }

  ///***@response e a resposta do servidor e @funcFromMap converte a resposta do servidor em algo @namedResponse e caso o servidor tenha um nome na resposta
  static ResponsePaginated getResponsePaginated<T>(
      CodeResponse response, Function funcFromMap,
      {String namedResponse, int status}) {
    if (response?.sucess == null || response.error != null) {
      return ResponsePaginated(
          error: response.error ?? "Sem resposta do servidor!");
    }
    if (response.sucess.length == 0) {
      return ResponsePaginated.fromMap(List<T>());
    }
    var tempResp = namedResponse != null
        ? response?.sucess[namedResponse]
        : response?.sucess;
    List<T> listElementGeneric = List<T>();
    List listElement = ObjectUtils.parseToObjectList<T>(tempResp,
        defaultValue: tempResp, isContent: true);

    if (listElement.isNotEmpty) {
      for (var columns in listElement) {
        var order = funcFromMap(columns);
        listElementGeneric.add(order);
      }
    }
    return ResponsePaginated.fromMap(listElementGeneric);
  }

  ///***@response e a resposta do servidor e @funcFromMap converte a resposta do servidor em algo
  static ResponsePaginated getResponsePaginatedObject<T>(
      CodeResponse response, Function funcFromMap,
      {TYPERESPONSE isObject , String namedResponse}) {
    if (isObject == TYPERESPONSE.LIST) {
      return getResponsePaginated(response, funcFromMap,
          namedResponse: namedResponse);
    } else {
      if (response?.sucess == null || response.error != null) {
        return ResponsePaginated(
            error: response.error ?? "Falha ao carregar dados",
        );
      }
      var tempResp = namedResponse != null
          ? response?.sucess[namedResponse]
          : response?.sucess;
      var object = ObjectUtils.parseToMap(response?.sucess,
          defaultValue: response?.sucess);

      return ResponsePaginated.fromMap(funcFromMap(object));
    }
  }

  ///***@service e o nome do servico  @body e o body passado na requisicao  @result e o resultado do servidor
  static String getErrorBody(String service, dynamic body, dynamic result) {
    var error = ObjectUtils.parseToMap(result) ?? result;

    if (error is Map) {
      return error["errorMessage"]["message"]?.toString() ??
          error["errorDevMessage"]["message"]?.toString() ??
          error["titulo"]?.toString() ??
          error["message"]?.toString() ??
          error["error_description"]?.toString() ??
          error["error"]?.toString();
    }
    if (error?.toString()?.contains("html") ?? false) {
      return (error?.toString()?.contains("Cannot") ?? false)
          ? "Serviço não existe"
          : "Servidor indisponível";
    } else {
      return error?.toString();
    }
  }
}
