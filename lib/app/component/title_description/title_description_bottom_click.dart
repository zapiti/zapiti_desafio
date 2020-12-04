

import 'package:flutter/material.dart';
import 'package:zapiti_desafio/app/component/simple/line_view_widget.dart';
import 'package:zapiti_desafio/app/utils/theme/app_theme_utils.dart';

Widget titleDescriptionBottomClick(String title, IconData imageAsset,{Function action, bool disableLine = false}) {
  return InkWell(onTap: (){

  },
      child: Column(children: [

                Icon(imageAsset),
                Expanded(child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),

                    child:  Text(
                  title,
                  style: AppThemeUtils.normalSize(color:  AppThemeUtils.black),
                ))),
              ],
            )
  );
}
