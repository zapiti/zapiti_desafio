import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_icons/flutter_icons.dart';
import 'package:zapiti_desafio/app/utils/string/string_file.dart';
import 'package:zapiti_desafio/app/utils/theme/app_theme_utils.dart';

var _isOpen = false;

void showTextFieldGenericDialog(
    {VoidCallback positiveCallback,
    VoidCallback negativeCallback,
    String title,
    BuildContext context,
    String positiveText,
    TextEditingController controller,
    TextInputType keyboardType,
    String hintText,
    String maxTitle,
    int lines,
    List<TextInputFormatter> inputFormatters,
    IconData icon,
    String erroText,
    int minSize}) {

  if (!_isOpen) {
    showDialog(
        context: context,
        builder: (BuildContext context) => _DialogGeneric(
              positiveCallback: positiveCallback,
              negativeCallback: negativeCallback,
              icon: icon,
              controller: controller,
              masterTitle: maxTitle,
              inputFormatters: inputFormatters,
              lines: lines,
              hintText: hintText,
              minSize: minSize,
              erroText: erroText,
              keyboardType: keyboardType,
              title: title,
              positiveText: positiveText,
            ));
  } else {
    _isOpen = true;
  }
}

class _DialogGeneric extends StatefulWidget {
  final VoidCallback positiveCallback;
  final VoidCallback negativeCallback;
  final TextEditingController controller;
  final String title;
  final String positiveText;
  final int lines;
  final int minSize;
  final String hintText;
  final String masterTitle;
  final IconData icon;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final erroText;

  _DialogGeneric(
      {this.positiveCallback,
      this.icon,
      this.negativeCallback,
      this.title,
      this.controller,
      this.keyboardType,
      this.positiveText,
      this.lines,
      this.masterTitle,
      this.hintText,
      this.inputFormatters,
      this.minSize,
      this.erroText});

  @override
  __DialogGenericState createState() => __DialogGenericState();
}

class __DialogGenericState extends State<_DialogGeneric> {
  String error;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
            child: Container(
                width: MediaQuery.of(context).size.width > 450
                    ? 400
                    : MediaQuery.of(context).size.width * 0.8,
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Material(
                    color: Colors.transparent,
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.transparent,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: ListBody(children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 0, bottom: 0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              border: Border.all(color: Colors.white, width: 0),
                              shape: BoxShape.rectangle,
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                    decoration: BoxDecoration(
                                        color: AppThemeUtils.colorPrimary,
                                        border: Border.all(
                                          color: Colors.transparent,
                                        ),
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            topLeft: Radius.circular(20))),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 5, bottom: 5, left: 0),
                                          child: Icon(
                                            MaterialCommunityIcons
                                                .file_document_edit,
                                            color: AppThemeUtils.whiteColor,
                                            size: 30,
                                          ),
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(
                                                top: 20, bottom: 20, left: 3),
                                            child: Text(
                                              widget.masterTitle ?? "Eba",
                                              style:
                                                  AppThemeUtils.normalBoldSize(
                                                      color: AppThemeUtils
                                                          .whiteColor,
                                                      fontSize: 18),
                                            )),
                                      ],
                                    )),
                                Container(
                                  padding: EdgeInsets.only(top: 0, bottom: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    border: Border.all(
                                        color: Colors.white, width: 1),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        child: Text(
                                          widget.title,
                                          style: AppThemeUtils.normalSize(),
                                        ),
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(
                                              right: 20,
                                              left: 20,
                                              bottom: 10,
                                              top: 5),
                                          child: TextField(
                                            keyboardType: widget.keyboardType,
                                            controller: widget.controller,
                                            maxLines: widget.lines,
                                            inputFormatters:
                                                widget.inputFormatters,
                                            onChanged: (text) {
                                              if (error != null) {
                                                setState(() {
                                                  error = null;
                                                });
                                              }
                                            },
                                            decoration: InputDecoration(
                                                hintText: widget.hintText,
                                                errorText: error,
                                                border:
                                                    const OutlineInputBorder(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    const Radius.circular(10.0),
                                                  ),
                                                  borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 0.3),
                                                )),
                                          )),
                                      Container(
                                        padding: EdgeInsets.only(top: 5),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Expanded(
                                                child: Center(
                                                    child: Container(
                                                        height: 50,
                                                        width: 200,
                                                        margin: EdgeInsets.only(
                                                            right: 10,
                                                            left: 10,
                                                            bottom: 10,
                                                            top: 5),
                                                        child: Container(
                                                          child: RaisedButton(
                                                            color: Colors
                                                                .grey[400],
                                                            elevation: 0,
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Text(
                                                              "Cancelar",
                                                              style: AppThemeUtils
                                                                  .normalBoldSize(
                                                                color: AppThemeUtils
                                                                    .whiteColor,
                                                              ),
                                                            ),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            8)),
                                                                side: BorderSide(
                                                                    color: Colors
                                                                            .grey[
                                                                        400],
                                                                    width: 1)),
                                                          ),
                                                        )))),
                                            Expanded(
                                                child: Center(
                                                    child: Container(
                                                        height: 50,
                                                        width: 200,
                                                        margin: EdgeInsets.only(
                                                            right: 10,
                                                            left: 10,
                                                            bottom: 10,
                                                            top: 5),
                                                        child: RaisedButton(
                                                          color: AppThemeUtils
                                                              .colorPrimary,
                                                          elevation: 0,
                                                          onPressed: () {
                                                            if (widget
                                                                    .minSize ==
                                                                null) {
                                                              widget
                                                                  .positiveCallback();
                                                              Navigator.of(context).pop();
                                                            } else {
                                                              if (widget
                                                                      .minSize <
                                                                  widget
                                                                      .controller
                                                                      .text
                                                                      .length) {
                                                                widget
                                                                    .positiveCallback();
                                                                Navigator.of(context).pop();
                                                              } else {
                                                                setState(() {
                                                                  error = widget
                                                                      .erroText;
                                                                });
                                                              }
                                                            }
                                                          },
                                                          child: AutoSizeText(
                                                            widget.positiveText ??
                                                                "Confirmar",
                                                            maxLines: 1,
                                                            style: AppThemeUtils
                                                                .normalBoldSize(
                                                              color: AppThemeUtils
                                                                  .whiteColor,
                                                            ),
                                                          ),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          8))),
                                                        )))),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]))))));
  }
}
