import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:zapiti_desafio/app/core/auth/auth_repository_interface.dart';
import 'package:zapiti_desafio/app/image/image_path.dart';
import 'package:zapiti_desafio/app/routes/constants_routes.dart';
import 'package:zapiti_desafio/app/utils/theme/app_theme_utils.dart';
import '../../app_bloc.dart';
import 'widget/animated_splash.dart';

class SplashPage extends StatelessWidget {
  var appBloc = Modular.get<AppBloc>();

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(AppThemeUtils.colorPrimary);

    precacheImage(AssetImage(ImagePath.imageLogo), context);

    return AnimatedSplash(
      imagePath: ImagePath.imageLogo,
      customFunction: () {

        redirectToPage(context);
      },
      duration: 30,
    );
  }
}

void redirectToPage(BuildContext context) {
  final auth = Modular.get<IAuthRepository>();
  final appBloc = Modular.get<AppBloc>();

  if (!kIsWeb) {
    _redirectToAuth(context, auth, appBloc);
  } else {
    _redirectToAuth(context, auth, appBloc);
  }
}

void _redirectToAuth(
    BuildContext context, IAuthRepository auth, AppBloc appBloc) {
  appBloc.getCurrentUserFutureValue().then((currentUser) {
    print("user ${currentUser?.toMap()}");
    if (currentUser != null) {
      try {
        appBloc.currentUserSubject.sink.add(currentUser);

        Modular.to.pushReplacementNamed(ConstantsRoutes.HOMEPAGE);
      } catch (ex) {
        Modular.to.pushReplacementNamed(ConstantsRoutes.HOMEPAGE);
      }
    } else {
      Modular.to.pushReplacementNamed(ConstantsRoutes.LOGIN);
    }
  });
}
