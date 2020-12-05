import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:zapiti_desafio/app/component/appbar/date_app_bar_custtom.dart';
import 'package:zapiti_desafio/app/component/load/load_elements.dart';
import 'package:zapiti_desafio/app/component/state_view/empty_view_mobile.dart';
import 'package:zapiti_desafio/app/modules/home/modules/init/init_bloc.dart';
import 'package:zapiti_desafio/app/modules/home/modules/init/model/news.dart';
import 'package:zapiti_desafio/app/modules/home/modules/init/widget/mobile/item_list_news.dart';

import 'package:zapiti_desafio/app/utils/string/string_file.dart';
import 'package:zapiti_desafio/app/utils/theme/app_theme_utils.dart';

import 'my_auto_page.dart';

class InitMobilePage extends StatefulWidget {
  @override
  _InitMobilePageState createState() => _InitMobilePageState();
}

class _InitMobilePageState extends State<InitMobilePage>
    with SingleTickerProviderStateMixin {
  final _initBloc = Modular.get<InitBloc>();

  @override
  void initState() {
    super.initState();
    _initBloc.getFakeListPost();
    _initBloc.getRealListPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          DateAppBarCustom(),
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                    child: Container(
                        padding: EdgeInsets.all(10),
                        color: AppThemeUtils.colorPrimary40,
                        child: Text(
                          StringFile.postFix,
                          style: AppThemeUtils.normalBoldSize(fontSize: 16),
                          textAlign: TextAlign.center,
                        ))),
                SliverToBoxAdapter(
                    child: Container(
                        height: 200,
                        child: StreamBuilder<List<News>>(
                            stream: _initBloc.listFakePost,
                            initialData: [],
                            builder: (context, snapshot) =>
                                snapshot.connectionState ==
                                        ConnectionState.waiting
                                    ? loadElements(context)
                                    : MyAutoPage(snapshot.data)))),
                SliverToBoxAdapter(
                    child: Container(
                        padding: EdgeInsets.all(10),
                        color: AppThemeUtils.colorPrimary40,
                        child: Text(
                          StringFile.postCommunnity,
                          style: AppThemeUtils.normalBoldSize(fontSize: 16),
                          textAlign: TextAlign.center,
                        ))),
                SliverToBoxAdapter(
                    child: StreamBuilder<List<News>>(
                        stream: _initBloc.listRealPost,
                        builder: (context, snapshot) => snapshot
                                        .connectionState ==
                                    ConnectionState.waiting ||
                                snapshot.data == null
                            ? loadElements(context)
                            : snapshot.data.isEmpty
                                ? emptyViewMobile(context)
                                : Container(
                                    child: new ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: snapshot.data.length,
                                        padding: EdgeInsets.only(bottom: 50),
                                        itemBuilder: (ctx, index) =>
                                            ItemListNews(
                                                snapshot.data[index], index),
                                        physics:
                                            const NeverScrollableScrollPhysics())))),
                // ListView.builder(itemCount:snapshot.data.length,itemBuilder: (context,index)=>,)),)
              ],
            ),
          )
        ],
      ),
    );
  }
}
