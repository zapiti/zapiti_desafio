import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:zapiti_desafio/app/component/dialog/dialog_generic.dart';
import 'package:zapiti_desafio/app/component/simple/line_view_widget.dart';
import 'package:zapiti_desafio/app/image/image_path.dart';
import 'package:zapiti_desafio/app/modules/home/modules/init/init_bloc.dart';
import 'package:zapiti_desafio/app/modules/home/modules/init/model/news.dart';
import 'package:zapiti_desafio/app/utils/colors/random.dart';
import 'package:zapiti_desafio/app/utils/date_utils.dart';
import 'package:zapiti_desafio/app/utils/string/string_file.dart';
import 'package:zapiti_desafio/app/utils/theme/app_theme_utils.dart';
import 'package:zapiti_desafio/app/utils/utils.dart';

import '../../../../../../app_bloc.dart';

class ItemListNews extends StatelessWidget {
  News news;
  int index;
  final initBloc = Modular.get<InitBloc>();
  var appBloc = Modular.get<AppBloc>();

  ItemListNews(this.news, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(maxHeight: 210),
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Card(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                      width: 70,
                      height: 70,
                      padding: EdgeInsets.all(10),
                      child: FadeInImage(
                        imageErrorBuilder: (BuildContext context,
                            Object exception, StackTrace stackTrace) {
                          return Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: RandomHexColor().colorRandom()),
                              child: index % 2 == 0
                                  ? CircleAvatar(
                                      radius: 30,
                                      child: ClipOval(
                                          child: Image.network(
                                        ImagePath.radom(index),
                                      )),
                                    )
                                  : Center(
                                      child: Text(
                                      news.user.name
                                          .toString()
                                          .substring(0, 1)
                                          .toUpperCase(),
                                      style: AppThemeUtils.normalSize(
                                          color: Colors.black, fontSize: 30),
                                    )));
                        },
                        placeholder: AssetImage(ImagePath.imageLoading),
                        image: NetworkImage("${news.user.profile_picture}"),
                        fit: BoxFit.cover,
                        height: 100.0,
                        width: 100.0,
                      )),
                  Expanded(
                      child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "${news.user.name}",
                            style: AppThemeUtils.normalBoldSize(),
                          )),
                      Container(
                          child: Text(
                            DateUtils.parseDateTimeFormat(
                                    news.message.created_at,
                                    format: "dd/MM/yyyy <> HH:mm")
                                .replaceAll("<>", "às"),
                            textAlign: TextAlign.end,
                            style: AppThemeUtils.normalSize(fontSize: 10),
                          ),
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 0)),
                    ],
                  ))
                ],
              ),
              lineViewWidget(),
              Expanded(
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: AutoSizeText(
                        Utils.truncate("${news.message.content}", 280),
                        style: AppThemeUtils.normalSize(),
                        minFontSize: 12,
                        maxFontSize: 14,
                        textAlign: TextAlign.left,
                        maxLines: 6,
                        overflow: TextOverflow.ellipsis,
                      ))),
              news.user.uid == null
                  ? SizedBox()
                  : news.user.uid != appBloc.getCurrentUserValue().uid.toString()
                      ? SizedBox()
                      : Container(
                          margin: EdgeInsets.all(5),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              FloatingActionButton(
                                heroTag: "989",
                                child: Icon(
                                  Icons.edit,
                                  color: AppThemeUtils.whiteColor,
                                ),
                                backgroundColor: AppThemeUtils.colorSecundary,
                                onPressed: () {
                                  initBloc.editPost(context, news);
                                },
                                mini: true,
                              ),
                              FloatingActionButton(
                                heroTag: "898",
                                child: Icon(
                                  Icons.delete,
                                  color: AppThemeUtils.whiteColor,
                                ),
                                backgroundColor: AppThemeUtils.colorSecundary,
                                onPressed: () {
                                  showGenericDialog(
                                      context: context,
                                      title: StringFile.atencao,
                                      description:
                                          "Deseja excluir esta postagem?",
                                      iconData: Icons.error_outline,
                                      negativeCallback: () {},
                                      positiveCallback: () {
                                        initBloc.deletePost(context, news);
                                      },
                                      positiveText: StringFile.ok);
                                },
                                mini: true,
                              )
                            ],
                          ))
            ],
          ),
        ));
  }
}
