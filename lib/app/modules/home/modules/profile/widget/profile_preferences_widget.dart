import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zapiti_desafio/app/core/util/color_util.dart';

class ProfilePreferencesWidget extends StatelessWidget {
  final List<String> preferences;

  ProfilePreferencesWidget({@required this.preferences});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    CupertinoIcons.heart_fill,
                    color: ColorUtil.primaryColor,
                  ),
                ),
                Text(
                  "Preferências",
                  style: TextStyle(color: Colors.grey, fontSize: 24),
                )
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _getListPreferences(context),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 0, 16),
                child: Icon(
                  CupertinoIcons.right_chevron,
                  color: Colors.grey,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _getListPreferences(BuildContext context) {
    if (preferences == null || preferences.isEmpty) {
      return Text(
        "Nenhuma preferência selecionada",
        style: TextStyle(color: Colors.grey),
      );
    }

    var size = MediaQuery.of(context).size;
    final double itemHeight = 40;
    final double itemWidth = size.width / 2;

    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: (itemWidth / itemHeight),
      children: List.generate(preferences.length, (index) {
        return Container(
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  CupertinoIcons.checkmark_square,
                  color: Colors.grey,
                ),
              ),
              Text(
                preferences[index],
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 15, color: Colors.grey),
              )
            ],
          ),
        );
      }),
    );
  }
}
