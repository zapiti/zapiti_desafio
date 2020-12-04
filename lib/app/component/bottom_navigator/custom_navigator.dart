import 'package:flutter/material.dart';
import 'package:zapiti_desafio/app/component/title_description/title_description_bottom_click.dart';
import 'package:zapiti_desafio/app/utils/theme/app_theme_utils.dart';

class CustomNavigator extends StatelessWidget {
  CustomNavigator();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(children: [
          Container(
            height: 56.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: AppThemeUtils.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.zero,
                topRight: Radius.zero,
                bottomLeft: Radius.zero,
                // bottomRight: Radius.circular(28.0),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                    child: titleDescriptionBottomClick(
                        "Objetivos",
                        Icons.list_alt,
                        action: (){})),
                Expanded(
                    child: titleDescriptionBottomClick(
                        "Histórico",
                        Icons.list_alt,
                        action: (){})),
                Expanded(
                    child: titleDescriptionBottomClick(
                        "Perfil",
                        Icons.list_alt,
                        action: (){})),
                Expanded(
                    child: titleDescriptionBottomClick(
                        "Configurações",
                        Icons.list_alt,
                        action: (){})),
                Expanded(
                    child: Container()),

              ],
            ),
          )
        ],)  );
  }
}
