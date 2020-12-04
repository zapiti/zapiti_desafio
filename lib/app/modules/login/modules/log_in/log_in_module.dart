import 'log_in_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'log_in_page.dart';

class LogInModule extends ChildModule {
  @override
  List<Bind> get binds => [

    Bind((i) => LogInBloc())
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => LogInPage()),
      ];

  static Inject get to => Inject<LogInModule>.of();
}
