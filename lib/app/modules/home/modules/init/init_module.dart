import 'package:zapiti_desafio/app/modules/home/modules/init/core/init_repository.dart';

import 'init_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'init_page.dart';

class InitModule extends ChildModule {
  @override
  List<Bind> get binds => [
    Bind((i) => InitBloc()),
    Bind((i) => InitRepository()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => InitPage()),
      ];

  static Inject get to => Inject<InitModule>.of();
}
