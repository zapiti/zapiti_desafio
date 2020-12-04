import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:zapiti_desafio/app/image/image_path.dart';
import 'package:zapiti_desafio/app/modules/splash/funny/widget/animated_splash_funny.dart';
import 'package:zapiti_desafio/app/routes/constants_routes.dart';

import '../../../app_bloc.dart';

class SplashFunnyPage extends StatelessWidget {
  var appBloc = Modular.get<AppBloc>();

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage(ImagePath.funnyImage), context);

    return AnimatedSplashFunny(
      imagePath: ImagePath.funnyImage,
      customFunction: () {
        redirectToPage(context);
      },
      duration: 3000,
    );
  }
}

void redirectToPage(BuildContext context) {
  if (!kIsWeb) {
    _redirectToAuth(
      context,
    );
  } else {
    _redirectToAuth(
      context,
    );
  }
}

void _redirectToAuth(BuildContext context) {
  var appBloc = Modular.get<AppBloc>();
  appBloc.getCurrentUserFutureValue().then((currentUser) {
    print("user ${currentUser?.toMap()}");
    if (currentUser != null) {
      try {
        Modular.to.pushReplacementNamed(ConstantsRoutes.HOMEPAGE);
      } catch (ex) {
        Modular.to.pushReplacementNamed(ConstantsRoutes.HOMEPAGE);
      }
    } else {
      Modular.to.pushReplacementNamed(ConstantsRoutes.LOGIN);
    }
  });
}
