
import 'dart:async'; //For StreamController/Stream
import 'package:connectivity/connectivity.dart';

class NetWorkService {

  ///**Verifica se possui conexão com a rede
 static Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

}
