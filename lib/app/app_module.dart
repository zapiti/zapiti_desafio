import 'package:dio/dio.dart';
import 'package:zapiti_desafio/app/modules/home/modules/init/init_module.dart';
import 'package:zapiti_desafio/app/modules/home/modules/profile/profile_module.dart';
import 'package:zapiti_desafio/app/modules/login/modules/recovery_pass/recovery_pass_module.dart';

import 'app_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

import 'app_widget.dart';
import 'guard/router_login_guard.dart';
import 'guard/router_permission_guard.dart';
import 'modules/home/home_module.dart';
import 'modules/login/core/auth_repository.dart';
import 'modules/login/login_bloc.dart';
import 'modules/login/login_module.dart';
import 'modules/login/modules/log_in/log_in_module.dart';
import 'modules/login/modules/register/register_module.dart';
import 'modules/splash/splash_page.dart';
import 'routes/constants_routes.dart';
import 'utils/preferences/local_data_store.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppBloc()),
        Bind((i) => LocalDataStore()),
        Bind((i) => LoginBloc()),
        Bind((i) => AuthRepository()),
        Bind((i) => Dio())
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          Modular.initialRoute,
          child: (_, args) => SplashPage(),
          transition: TransitionType.fadeIn,
        ),
        ModularRouter(ConstantsRoutes.HOMEPAGE,
            module: HomeModule(),
            transition: TransitionType.fadeIn,
            guards: [RouterPermissionGuard()]),
        ModularRouter(ConstantsRoutes.LOGIN,
            module: LoginModule(), guards: [RouterLoginGuard()]),
        ModularRouter(ConstantsRoutes.LOGIN_PAGE, module: LogInModule()),
        ModularRouter(ConstantsRoutes.REGISTRE_PAGE, module: RegisterModule()),

        ModularRouter(ConstantsRoutes.RECOVERYPASS,
            module: RecoveryPassModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
