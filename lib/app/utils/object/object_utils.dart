import 'dart:convert';

import 'package:zapiti_desafio/app/models/page/response_paginated.dart';




class ObjectUtils {
  ///***pega um objeto e converte para string
  static String parseToString(data, [String defaultValue = '']) {
    if (data == null) return defaultValue;
    try {
      return data as String;
    } on Exception catch (exe) {
      print("Parse error $exe $data");
      return defaultValue;
    }
  }
  ///***pega um objeto e converte para int
  static dynamic parseToInt(data, {dynamic defaultValue = 0}) {
    if (data == null) return defaultValue;
    try {
      return double.parse(data?.toString() ?? "0").toInt();
    } on Exception catch (exe) {
      print("Parse error $exe $data");
      return 0;
    }
  }
  ///***pega um objeto e converte para double
  static double parseToDouble(data, {dynamic defaultValue = 0.0}) {
    if (data == null) return defaultValue;
    try {
      if (data is double) {
        return data;
      } else {
        return double.tryParse(data.toString());
      }
    } on Exception catch (exe) {
      print("Parse error $exe $data");
      return defaultValue;
    }
  }
  ///***pega a resposta do servidor e verifica se e um objeto ou lista
  static List<T> parseToObjectList<T>(dynamic object,
      {dynamic defaultValue, dynamic type, bool isContent = false}) {
    if (object == null) {
      return [];
    }
    try {
      if (isContent) {
        if (object is Map) {
          if (object["content"] != null) {
            if (object["content"] is List) {
              return object["content"].cast<T>().toList();
            } else {
              return [object["content"]].cast<T>().toList();
            }
          }
        }
      } else if (object is List) {
        return object.cast<T>().toList();
      }
      return object.cast<T>().toList();
    } on Exception catch (exe) {
      return object.cast<T>().toList();
    } catch (error) {
      print("Parse error $error $object");
      return defaultValue;
    }
  }

  ///***verifica se a resposta do servidor esta vazia
  static bool isEmpty(data) {
    if (data == null) {
      return true;
    } else if (data is ResponsePaginated) {
      if (data.content == null) {
        return true;
      }
      if (data.content is List) {
        return data.content.isEmpty;
      } else {
        return false;
      }
    }

    return data.toString().isEmpty;
  }


  ///***pega a resposta do servidor e verifica se e um objeto
  static dynamic parseToMap(result, {dynamic defaultValue = "{}"}) {
    if (result is Map) {
      return result;
    } else {
      if (result == null) {
        return defaultValue;
      }
      try {
        var jsons = json.decode(result.toString());
        return jsons;
      } catch (e) {
        return defaultValue;
      }

      return defaultValue;
    }
  }


}
