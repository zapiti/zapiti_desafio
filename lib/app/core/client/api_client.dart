import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:zapiti_desafio/app/configuration/app_configuration.dart';
import 'package:zapiti_desafio/app/core/auth/auth_repository_interface.dart';
import 'package:zapiti_desafio/app/modules/login/login_bloc.dart';

class ApiClient {
  var _dio = Modular.get<Dio>();
  var _authToken = Modular.get<IAuthRepository>();

  ///Configura a otilizacao da api para fazer requisicao
  Future<Dio> getApiClient() async {
    var token = await _authToken.getToken();
    var baseUrl = await AppConfiguration.baseUrl();

    _dio.interceptors.clear();

    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      // Do something before request is sent
      var header = getHeaderToken(token: token);
      options.headers = header;
      options.baseUrl = baseUrl;
      options.connectTimeout = 50 * 1000; // 60 seconds
      options.receiveTimeout = 50 * 1000; // 60 seconds

      print("Url=> $baseUrl");
      return options;
    }, onResponse: (Response response) {
      return response; // continue
    }, onError: (DioError error) async {
      if (error.response?.statusCode == 403) {
        _dio.interceptors.requestLock.lock();
        _dio.interceptors.responseLock.lock();
        Modular.get<LoginBloc>().getLogout();
        _dio.interceptors.requestLock.unlock();
        _dio.interceptors.responseLock.unlock();
        return error;
      } else {
        return error;
      }
    }));

    return _dio;
  }

  static Map<String, String> getHeaderToken({String token}) {
    if (token == null) {
      return <String, String>{
        'content-Type': 'application/json',
        'accept': 'application/json',
      };
    } else {
      return <String, String>{
        'content-Type': 'application/json',
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
    }
  }
}
