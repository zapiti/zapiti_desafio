import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:uuid/uuid.dart';
import 'package:zapiti_desafio/app/component/bottom_navigator/my_custom_buttom.dart';
import 'package:zapiti_desafio/app/component/dialog/dialog_generic.dart';

import 'package:zapiti_desafio/app/component/external_lib/flutter_speed_dial_material_design.dart';
import 'package:zapiti_desafio/app/modules/home/home_bloc.dart';
import 'package:zapiti_desafio/app/modules/home/modules/profile/profile_bloc.dart';
import 'package:zapiti_desafio/app/modules/login/login_bloc.dart';

import 'package:zapiti_desafio/app/utils/string/string_file.dart';
import 'package:zapiti_desafio/app/utils/theme/app_theme_utils.dart';

import 'modules/init/init_module.dart';
import 'modules/profile/profile_module.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController _tabController;
  var homeBloc = Modular.get<HomeBloc>();
  var profileBloc = Modular.get<ProfileBloc>();

  final GlobalKey<NavigatorState> _profileTabNavKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _homeTabNavKey = GlobalKey<NavigatorState>();

  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);

    profileBloc.getUserInfo();
    _tabController.addListener(() {
      homeBloc.selectedMenu.sink.add(_tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentNavigatorKey().currentState.canPop()) {
          return !await currentNavigatorKey().currentState.maybePop();
        } else {
          return await showGenericDialog(
              context: context,
              title: StringFile.atencao,
              description: StringFile.desejaFechar,
              iconData: Icons.error_outline,
              negativeCallback: () {},
              positiveCallback: () {
                SystemNavigator.pop();
              },
              positiveText: StringFile.sim);
          return false;
        }
      },
      child: Scaffold(
        body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
              RouterOutlet(
                module: InitModule(),
                navigatorKey: _homeTabNavKey,
              ),
              RouterOutlet(
                module: ProfileModule(),
                navigatorKey: _profileTabNavKey,
              ),
            ]),
        floatingActionButton: _buildFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28.0),
              topRight: Radius.zero,
              bottomLeft: Radius.zero,
            ),
            child: BottomAppBar(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: CircularNotchedRectangle(),
              child: Container(
                height: 70.0,
                color: AppThemeUtils.colorPrimary,
                child: StreamBuilder<int>(
                    stream: homeBloc.selectedMenu,
                    builder: (context, snapshot) => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            myCusttomButtom(
                                icon: Icons.home,
                                onTap: () {
                                  _tabController.animateTo(0);
                                },
                                text: "Início",
                                selected: snapshot.data == 0),
                            myCusttomButtom(
                                icon: Icons.person,
                                onTap: () {
                                  _tabController.animateTo(1);
                                },
                                text: "Perfil",
                                selected: snapshot.data == 1),
                            myCusttomButtom(
                                icon: Icons.exit_to_app,
                                selected: snapshot.data == -1,
                                onTap: () {
                                  Modular.get<LoginBloc>().getLogout();
                                },
                                text: "Sair"),
                            SizedBox(
                              width: 60,
                            )
                          ],
                        )),
              ),
            )),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    final TextStyle customStyle =
        TextStyle(inherit: false, color: Colors.black);
    var icons = [
      SpeedDialAction(
          child: Icon(Icons.mode_edit),
          label: Text('Criar postagem', style: customStyle)),
      SpeedDialAction(
        child: Icon(Icons.date_range),
        label: Text('Selecionar data', style: customStyle),
      ),
    ];

    return StreamBuilder<int>(
        stream: homeBloc.selectedMenu,
        initialData: 0,
        builder: (context, snapshot) =>
            MediaQuery.of(context).viewInsets.bottom != 0
                ? Container()
                : snapshot.data == 1
                    ? Container(
                        child: FloatingActionButton(
                          heroTag: Uuid().v4(),
                          backgroundColor: AppThemeUtils.whiteColor,
                          child: Icon(
                            Icons.edit,
                            color: AppThemeUtils.colorSecundary,
                          ),
                          onPressed: () {
                            var profileBloc = Modular.get<ProfileBloc>();

                            profileBloc.editProfile(context);
                          },
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.only(bottom: 0),
                        child: SpeedDialFloatingActionButton(
                          actions: icons,
                          backgroundColor: AppThemeUtils.colorPrimary,
                          childOnFold: Icon(Icons.add, key: UniqueKey()),
                          screenColor: Colors.black.withOpacity(0.3),
                          //childOnUnfold: Icon(Icons.add),
                          useRotateAnimation: false,
                          onAction: (i) {
                            if (i == 1) {
                              homeBloc.filterPost(context);
                            } else {
                              homeBloc.creatPostOrEdit(context);
                            }
                          },

                          isDismissible: true,
                        )));
  }

  GlobalKey<NavigatorState> currentNavigatorKey() {
    switch (_tabController.index) {
      case 0:
        return _homeTabNavKey;
        break;
      case 1:
        return _homeTabNavKey;
        break;
    }

    return null;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
