import 'package:flutter/cupertino.dart';

class NotificationColoredCardWidget extends StatelessWidget {
  final Widget child;
  final Function action;

  NotificationColoredCardWidget({this.child, this.action});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 205, 229, 214),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        clipBehavior: Clip.antiAlias,
        child: child,
      ),
    );
  }
}
