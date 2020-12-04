import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Container loadElements(BuildContext context,
    {double size = 50,
    double width = double.infinity,
    Color color,
    bool isSimple = false,
    EdgeInsets margin, }) {
  return Container(
    width: width,
    height: size,
    margin: margin ?? EdgeInsets.only(top: 10),
    color: color,
    alignment: Alignment.center,
    child: CircularProgressIndicator(
      valueColor:
          AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColorLight),
      strokeWidth: 4,
    ),
  );
}
