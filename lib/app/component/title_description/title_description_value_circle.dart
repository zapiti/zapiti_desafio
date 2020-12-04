

import 'package:flutter/material.dart';
import 'package:zapiti_desafio/app/utils/theme/app_theme_utils.dart';

Widget titleDescriptionValueCircle(String title, String description,{Color color}) {
  return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Row(
        children: [
          Text(
            title,
            style: AppThemeUtils.normalBoldSize(color: color?? AppThemeUtils.black),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
            decoration: BoxDecoration(
                color: AppThemeUtils.colorPrimary,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            clipBehavior: Clip.antiAlias,
            child: Text(
              description,
              style: AppThemeUtils.smallSize(color: AppThemeUtils.whiteColor),
            ),
          ),
        ],
      ));
}
