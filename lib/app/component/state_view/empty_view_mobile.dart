import 'package:flutter/material.dart';
import 'package:zapiti_desafio/app/image/image_path.dart';
import 'package:zapiti_desafio/app/utils/string/string_file.dart';
import 'package:zapiti_desafio/app/utils/theme/app_theme_utils.dart';

Widget emptyViewMobile(BuildContext context,
    {String emptyMessage,
    VoidCallback tentarNovamente,
    bool isError = false,
    double height = 130.0,
    double heightImage = 50,
    double size,
    String buttomText}) {
  return Container(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Image.asset(
                ImagePath.imageLoading,
                height: 150,
                width: 150,
              )),
          Container(
            child: Text(
              emptyMessage ?? StringFile.semdados,
              maxLines: 6,textAlign: TextAlign.center,
              style: AppThemeUtils.normalSize(
                  color: isError
                      ? AppThemeUtils.colorError
                      : Theme.of(context).textTheme.bodyText1.color),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          tentarNovamente != null
              ? FlatButton(
                  onPressed: tentarNovamente,
                  child: Text(
                    buttomText ?? StringFile.atualizar,
                    style: AppThemeUtils.normalSize(
                        color: AppThemeUtils.colorSecundary),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      side: BorderSide(color: AppThemeUtils.colorSecundary)))
              : SizedBox(),
        ],
      )));
}
