import 'package:flutter/material.dart';

class ConstantsRoutes {
  static const String HOMEPAGE = '/homepage';
  static const String LOGIN = '/login';
  static const String RECOVERYPASS = '/recuperarsenha';

  static const String EXTRACTPAGE = '/extrato';

  static const String HELPPAGE = '/help';

  static const String REPAYMENTPAGE = '/payment';

  static const String  EXIT = '/exit';

  static const String REGISTRE_PAGE = '/registrar';

  static const  String LOGIN_PAGE = "/login_page";

  static String INIT = '/initial-tab';

  static String PROFILE  = '/profile-tab';

  ///***passe @route
  ///para pegar o nome da rota
  static String getNameByRoute(
    String route,
  ) {
    switch (route) {
      case ConstantsRoutes.HOMEPAGE:
        return "Início";
        break;
      case ConstantsRoutes.REPAYMENTPAGE:
        return "Reembolsos";
        break;
      case ConstantsRoutes.EXTRACTPAGE:
        return "Extratos";
        break;
      case ConstantsRoutes.HELPPAGE:
        return "Me ajuda";
        break;
      case ConstantsRoutes.EXIT:
        return "Sair";
        break;
      default:
        return "Início";
        break;
    }
  }
}
