import 'package:flutter_modular/flutter_modular.dart';
import 'package:zapiti_desafio/app/routes/constants_routes.dart';

import '../app_bloc.dart';

class RouterLoginGuard implements RouteGuard {
  @override
  bool canActivate(String url) {
    return true;
  }

  @override
  // TODO: implement executors
  List<GuardExecutor> get executors => [HomeExecutor()];
}

class HomeExecutor extends GuardExecutor {
  @override
  onGuarded(String path, {bool isActive}) {
    final _blocApp = Modular.get<AppBloc>();
    _blocApp.getCurrentUserFutureValue().then((value) {
      if (value == null) {
        if (path != ConstantsRoutes.LOGIN) {
          Modular.to.pushReplacementNamed(ConstantsRoutes.LOGIN);
        }
      } else {
        if (Modular.to.path == ConstantsRoutes.LOGIN ||
            Modular.to.path == Modular.initialRoute) {
          Modular.to.pushReplacementNamed(ConstantsRoutes.HOMEPAGE);
        }
      }
    });

    // Suppose login.
  }
}
