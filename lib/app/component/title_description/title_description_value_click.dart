

import 'package:flutter/material.dart';
import 'package:zapiti_desafio/app/component/simple/line_view_widget.dart';
import 'package:zapiti_desafio/app/utils/theme/app_theme_utils.dart';

Widget titleDescriptionValueClick(String title, String imageAsset,{Function action, bool disableLine = false}) {
  return InkWell(onTap: (){

  },
      child: Column(children: [
        Container(
            margin: EdgeInsets.symmetric(
              vertical: 10,horizontal: 20
            ),
            child: Row(
              children: [
                Image.asset(imageAsset),
                Expanded(child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),

                    child:  Text(
                  title,
                  style: AppThemeUtils.normalSize(color:  AppThemeUtils.black),
                ))),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),

                  child: Icon(Icons.arrow_forward_ios,color: AppThemeUtils.darkGray,),
                ),
              ],
            )),disableLine ? SizedBox():lineViewWidget()
      ],));
}
