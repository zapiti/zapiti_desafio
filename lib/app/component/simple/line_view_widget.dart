import 'package:flutter/material.dart';

Widget lineViewWidget(
    {Color color,
    double width = 2000,
    double boarder = 0,
    double height = 1,
    double bottom = 0,
    double top = 0,
    bool horizontal = true}) {
  return Container(
    margin: EdgeInsets.only(
        right: boarder, left: boarder, bottom: bottom, top: top),
    color: color ?? Colors.grey[300],
    width: horizontal ? width : 1,
    height: horizontal ? height : height,
  );
}
