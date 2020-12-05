

import 'package:flutter/material.dart';


/// Comportamento de rolagem personalizado para o [ChatView].
class CustomScrollBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
