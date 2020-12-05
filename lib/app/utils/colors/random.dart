import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zapiti_desafio/app/utils/colors/color_constants.dart';

class RandomHexColor {
  static  Color a1 = HexColor("#FF7F50");
  static  Color a2 = HexColor("#FFBF00");
  static  Color a3 = HexColor("#DFFF00");
  static  Color a4 = HexColor("#DE3163");
  static  Color a5 = HexColor("#9FE2BF");
  static  Color a6 = HexColor("#40E0D0");
  static  Color a7 = HexColor("#6495ED");
  static  Color a8 = HexColor("#CCCCFF");
  static  Color a9 = HexColor("800080");
  List<Color> hexColor = [a1, a2, a3,a4,a5,a6,a7,a8,a9];

  static final _random = Random();

  Color colorRandom() {
    return hexColor[_random.nextInt(8)];
  }
}