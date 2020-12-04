import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zapiti_desafio/app/utils/theme/app_theme_utils.dart';
import 'image_path.dart';

class GetLogoIcon extends StatelessWidget {
  final double width;
  final double height;

  GetLogoIcon({this.width: 500, this.height: 200});

  @override
  Widget build(BuildContext context) {
    return  Container(

        height: height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: Image.asset(
          ImagePath.imageLogo,
        ).image)));
  }
}
