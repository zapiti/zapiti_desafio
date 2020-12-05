import 'login_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'login_page.dart';

class LoginModule extends ChildModule {
  @override
  List<Bind> get binds => [Bind((i) => LoginBloc())];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => LoginPage(args.data)),
      ];

  static Inject get to => Inject<LoginModule>.of();
}
