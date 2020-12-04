import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:zapiti_desafio/app/models/pairs.dart';
import 'package:zapiti_desafio/app/utils/theme/app_theme_utils.dart';



class SelectButton extends StatefulWidget {
  final List<Pairs> title;
  final Function(Pairs) tapIndex;
  final int initialItem;

  SelectButton({this.title, this.initialItem, this.tapIndex});

  @override
  _SelectButtonState createState() => _SelectButtonState();
}

class _SelectButtonState extends State<SelectButton>
    with SingleTickerProviderStateMixin {
  var index;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        children: widget.title
            .map<Widget>((e) => Expanded(
                    child: RaisedButton(
                  color: index == widget.title.indexOf(e)
                      ?  AppThemeUtils.colorPrimary
                      : Colors.white,
                  elevation: 0,
                  onPressed: () {
                    if (widget.tapIndex != null) {
                      setState(() {
                        if (widget.title.indexOf(e) == index) {
                          index = null;
                          widget.tapIndex(null);
                        } else {
                          index = widget.title.indexOf(e);
                          widget.tapIndex(e);
                        }
                      });
                    }
                  },
                  child: Container(
                    height: 40,
                    child: Center(
                      child: AutoSizeText(
                        e.second,
                        maxLines: 1,
                        minFontSize: 12,
                        maxFontSize: 13,
                        textAlign: TextAlign.center,
                        style: AppThemeUtils.normalSize(
                            color: index == widget.title.indexOf(e)
                                ? Colors.white
                                :  AppThemeUtils.colorPrimary,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                      side: BorderSide(
                          color: index == widget.title.indexOf(e)
                              ? AppThemeUtils.colorPrimary
                              :  AppThemeUtils.colorPrimary,
                          width: 1)),
                )))
            .toList());
  }
}
