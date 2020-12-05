import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:zapiti_desafio/app/configuration/app_configuration.dart';
import 'package:zapiti_desafio/app/models/code_response.dart';
import 'package:zapiti_desafio/app/models/page/response_paginated.dart';
import 'package:zapiti_desafio/app/utils/network/network_service.dart';
import 'package:zapiti_desafio/app/utils/response/response_utils.dart';
import 'package:zapiti_desafio/app/utils/string/string_file.dart';

import 'client/api_client.dart';

enum TYPEREQUEST { PATCH, POST, PUT, GET, DELETE }
enum TYPERESPONSE { OBJECT, LIST }

class RequestCore {
  ///@serviceName e o nome do servico chamado
  ///@funcFromMap e conversao da sua funcao para algo que voce quer
  ///@body e o corpo da requisicao
  ///@typeRequest  e o tipo da requisicao
  ///@namedResponse e se a requisicao tem um nome
  ///@isImage e caso o enviado seja multpartFile
  ///isJsonResponse e caso nao precise dar parce no body pra json
  Future<ResponsePaginated> requestWithTokenToForm(
      {@required serviceName,
      @required funcFromMap,
      dynamic body,
      typeResponse: TYPERESPONSE.OBJECT,
      @required TYPEREQUEST typeRequest,
      String namedResponse,
      bool isImage = false,
      bool isJsonResponse = true}) async {
    try {
      debugPrint(
          "SERVICOCHAMADO = $serviceName body = ${jsonEncode(body ?? {})}");
    } catch (e) {}

    var checkCelular = await NetWorkService.check();
    if (!checkCelular) {
      return ResponsePaginated(error: StringFile.semConexaoRede);
    } else {
      if (AppConfiguration.isMockDevTest) {
        return ResponsePaginated();
      } else {
        var api = await ApiClient().getApiClient();

        try {
          Response response;
          switch (typeRequest) {
            case TYPEREQUEST.GET:
              response = await api.get(
                serviceName,
                options: Options(
                  contentType: "application/json;charset=UTF-8",
                ),
              );
              break;
            case TYPEREQUEST.POST:
              response = await api.post(
                serviceName,
                data: isJsonResponse
                    ? isImage
                        ? body
                        : jsonEncode(body ?? {})
                    : body,
                options: Options(
                  contentType: isImage
                      ? 'multipart/form-data'
                      : "application/json;charset=UTF-8",
                ),
              );
              break;

            case TYPEREQUEST.PUT:
              response = await api.put(
                serviceName,
                data: isJsonResponse
                    ? isImage
                        ? body
                        : jsonEncode(body ?? {})
                    : body,
                options: Options(
                  contentType: isImage
                      ? 'multipart/form-data'
                      : "application/json;charset=UTF-8",
                ),
              );
              break;

            case TYPEREQUEST.PATCH:
              response = await api.patch(
                serviceName,
                data: isJsonResponse
                    ? isImage
                        ? body
                        : jsonEncode(body ?? {})
                    : body,
                options: Options(
                  contentType: isImage
                      ? 'multipart/form-data'
                      : "application/json;charset=UTF-8",
                ),
              );
              break;
            case TYPEREQUEST.DELETE:
              response = await api.delete(
                serviceName,
                data: isJsonResponse
                    ? isImage
                        ? body
                        : jsonEncode(body ?? {})
                    : body,
                options: Options(
                  contentType: isImage
                      ? 'multipart/form-data'
                      : "application/json;charset=UTF-8",
                ),
              );
              break;
            default:
              response = await api.post(
                serviceName,
                data: isJsonResponse
                    ? isImage
                        ? body
                        : jsonEncode(body ?? {})
                    : body,
                options: Options(
                  contentType: isImage
                      ? 'multipart/form-data'
                      : "application/json;charset=UTF-8",
                ),
              );
              break;
          }

          var statusCode = response?.statusCode;
          print("Current status code: $statusCode");

          print(
              "##RETORNO-SERVICO(${typeRequest.toString()}) = $serviceName body = ${body ?? response?.data ?? {}}");
          if (statusCode == 200 || statusCode == 201 || statusCode == 202) {
            return ResponseUtils.getResponsePaginatedObject(
                CodeResponse(
                    sucess:  response?.data),
                funcFromMap,
                isObject: typeResponse,
                namedResponse: namedResponse);
          } else {
            return ResponseUtils.getResponsePaginatedObject(
                CodeResponse(error: response), funcFromMap);
          }
        } on DioError catch (e) {
          print(
              "***RETORNO-SERVICO (Erro)(${typeRequest.toString()}) = $serviceName body = ${body ?? e.response ?? {}}");

          var msg =
              ResponseUtils.getErrorBody(serviceName, body, e.response?.data);
          return ResponseUtils.getResponsePaginatedObject(
              CodeResponse(error: msg), funcFromMap);
        } on Exception catch (e) {
          var msg =
              ResponseUtils.getErrorBody(serviceName, body, e?.toString()) ??
                  "Sem descrição de erro";
          return ResponseUtils.getResponsePaginatedObject(
              CodeResponse(error: msg), funcFromMap);
        }
      }
    }
  }
}
