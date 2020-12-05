import 'package:flutter/material.dart';
import 'package:zapiti_desafio/app/utils/theme/app_theme_utils.dart';

Widget myCusttomButtom(
    {IconData icon, String text, Function() onTap, bool selected}) {
  return Expanded(
      child: Container(
          color: selected
              ? AppThemeUtils.colorSecundary
              : AppThemeUtils.colorPrimary,
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  icon,
                  color:
                      selected ? AppThemeUtils.whiteColor : AppThemeUtils.black,
                ),
                Text(
                  text,
                  style: AppThemeUtils.normalSize(
                    color: selected
                        ? AppThemeUtils.whiteColor
                        : AppThemeUtils.black,
                  ),
                )
              ],
            ),
            onTap: onTap,
          )));
}
