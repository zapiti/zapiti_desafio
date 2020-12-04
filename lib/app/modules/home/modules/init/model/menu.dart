
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:zapiti_desafio/app/routes/constants_routes.dart';

class Menu {
  String title;
  IconData icon;
  String route;

  bool hide;

  Menu({this.title, this.icon, this.route, this.hide});

  static List<Menu> getListWithPermission() {
    return _menuItems
        .where((element) => true,)
        .toList();
  }
}

List<Menu> _menuItems = [
  //REEMBOLSO
  Menu(
      title:
      ConstantsRoutes.getNameByRoute(ConstantsRoutes.REPAYMENTPAGE),
  icon: MaterialCommunityIcons.cash_multiple,
  route: ConstantsRoutes.REPAYMENTPAGE,
  hide: false,),
  Menu(
    title:
    ConstantsRoutes.getNameByRoute(ConstantsRoutes.EXTRACTPAGE),
    icon: MaterialCommunityIcons.receipt,
    route: ConstantsRoutes.EXTRACTPAGE,
    hide: false,),
  Menu(
    title:
    ConstantsRoutes.getNameByRoute(ConstantsRoutes.HELPPAGE),
    icon: MaterialCommunityIcons.help_circle_outline,
    route: ConstantsRoutes.HELPPAGE,
    hide: false,),
  Menu(
    title:
    ConstantsRoutes.getNameByRoute(ConstantsRoutes.EXIT),
    icon: MaterialCommunityIcons.exit_to_app,
    route: ConstantsRoutes.EXIT,
    hide: false,),

];
