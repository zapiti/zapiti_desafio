import 'package:flutter/material.dart';
import 'package:zapiti_desafio/app/modules/home/modules/init/model/menu.dart';

import 'menu_widget.dart';

class MenusPagesListWidget extends StatelessWidget {
  MenusPagesListWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        child: ListView.builder(
            itemCount: Menu.getListWithPermission().length ,
            padding: EdgeInsets.symmetric(horizontal: 15),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) =>
                MenuWidget(Menu.getListWithPermission()[index])));
  }
}
