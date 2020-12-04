import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:zapiti_desafio/app/component/bottom_navigator/my_custom_buttom.dart';
import 'package:zapiti_desafio/app/component/dialog/dialog_generic_calendar.dart';
import 'package:zapiti_desafio/app/component/external_lib/flutter_speed_dial_material_design.dart';
import 'package:zapiti_desafio/app/modules/home/home_bloc.dart';
import 'package:zapiti_desafio/app/modules/login/login_bloc.dart';
import 'package:zapiti_desafio/app/modules/login/login_module.dart';
import 'package:zapiti_desafio/app/routes/constants_routes.dart';
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

  final GlobalKey<NavigatorState> _timelineTabNavKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _pointTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _hollerithTabNavKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _menuTabNavKey = GlobalKey<NavigatorState>();

  void initState() {
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
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
          return await showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return CupertinoAlertDialog(
                      title: Text("Fechar o aplicativo?"),
                      actions: [
                        CupertinoButton(
                          child: Text("Não"),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                        ),
                        CupertinoButton(
                          child: Text(
                            "Sim",
                            style: TextStyle(color: CupertinoColors.systemRed),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                        )
                      ],
                    );
                  }) ??
              false;
        }
      },
      child: Scaffold(
        body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
              RouterOutlet(
                module: InitModule(),
                navigatorKey: _hollerithTabNavKey,
              ),
              RouterOutlet(
                module: ProfileModule(),
                navigatorKey: _hollerithTabNavKey,
              ),
            ]),
        floatingActionButton: _buildFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28.0),
              topRight: Radius.zero,
              bottomLeft: Radius.zero,
              // bottomRight: Radius.circular(28.0),
            ),
            child: BottomAppBar(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: CircularNotchedRectangle(),
              child: Container(
                height: 75.0,
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
                              
                                  // Modular.to.pushNamed(ConstantsRoutes.INIT);
                                },
                                text: "Início",
                                selected: snapshot.data == 0),
                            myCusttomButtom(
                                icon: Icons.person,
                                onTap: () {
                                  _tabController.animateTo(1);

                                  //  Modular.to.pushNamed(ConstantsRoutes.PROFILE);
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
    final icons = [
      SpeedDialAction(
          //backgroundColor: Colors.green,
          //foregroundColor: Colors.yellow,
          child: Icon(Icons.mode_edit),
          label: Text('Criar postagem', style: customStyle)),
      SpeedDialAction(
        child: Icon(Icons.date_range),
        label: Text('Selecionar data', style: customStyle),
      ),
    ];

    return Container(
        margin: EdgeInsets.only(bottom: 15),
        child: SpeedDialFloatingActionButton(
          actions: icons,
          backgroundColor: AppThemeUtils.colorPrimary,
          childOnFold: Icon(Icons.add, key: UniqueKey()),
          screenColor: Colors.black.withOpacity(0.3),
          //childOnUnfold: Icon(Icons.add),
          useRotateAnimation: false,
          onAction: (i) {
            if (i == 1) {
              showGenericDialogCalendar(
                  context: context, selectedDay: DateTime.now());
            } else {
              homeBloc.creatPost(context);
            }
          },
          // controller: _tabController,
          isDismissible: true,
          //backgroundColor: Colors.yellow,
          //foregroundColor: Colors.blue,
        ));
  }

  GlobalKey<NavigatorState> currentNavigatorKey() {
    switch (_tabController.index) {
      case 0:
        return _timelineTabNavKey;
        break;
      case 1:
        return _pointTabNavKey;
        break;
      case 2:
        return _hollerithTabNavKey;
        break;
      case 3:
        return _menuTabNavKey;
        break;
    }

    return null;
  }

  //Ids dos banner do ADMob
  final bannerAdIdAndroid = "ca-app-pub-5954339580493142/2212672162";
  final bannerAdIdIos =
      "ca-app-pub-5954339580493142/2212672162"; //TODO: Ver isso
  String getBannerId() => Platform.isIOS ? bannerAdIdIos : bannerAdIdAndroid;

//  BannerAd myBanner;

  @override
  void dispose() {
    // myBanner?.dispose();

    super.dispose();
  }

// @override
// void initState() {
//   super.initState();
//   // FirebaseAdMob.instance.initialize(appId: getBannerId());
//   //
//   // startBanner();
//   // displayBanner();
// }

// // Configuração dos banners que deverão ser exibido
// MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
//   keywords: <String>['flutterio', 'beautiful apps'],
//   contentUrl: 'https://flutter.io',
//   childDirected: false,
//   testDevices: <String>[],
// );

// void startBanner() {
//   myBanner = BannerAd(
//     adUnitId: BannerAd.testAdUnitId,
//     size: AdSize.banner,
//     targetingInfo: targetingInfo,
//     listener: (MobileAdEvent event) {
//       print("BannerAd event is $event");
//     },
//   );
// }
//
// void displayBanner() {
//   myBanner = buildBannerAd()..load();
// }

// BannerAd buildBannerAd() {
//   return BannerAd(
//       adUnitId: BannerAd.testAdUnitId,
//       size: AdSize.banner,
//       listener: (MobileAdEvent event) {
//         if (event == MobileAdEvent.loaded) {
//           myBanner..show(anchorType: AnchorType.bottom, anchorOffset: 50);
//         }
//       });
// }
}
