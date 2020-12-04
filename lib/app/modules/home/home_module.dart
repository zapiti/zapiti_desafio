import 'package:zapiti_desafio/app/routes/constants_routes.dart';

import 'home_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_page.dart';
import 'modules/init/init_module.dart';
import 'modules/profile/profile_module.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
    Bind((i) => HomeBloc()),
      ];

  @override
  List<ModularRouter> get routers => [

        ModularRouter(Modular.initialRoute, child: (_, args) => HomePage()),
    ModularRouter(ConstantsRoutes.PROFILE, module: ProfileModule()),
    ModularRouter(ConstantsRoutes.INIT, module: InitModule()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
