import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_bloc.dart';
import 'core/util/color_util.dart';

class AppWidget extends StatelessWidget {
  final _bloc = Modular.get<AppBloc>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Modular.navigatorKey,
      title: 'Boticario',
      theme: _bloc.getDefaultTheme(),
      initialRoute: '/',
      supportedLocales: [const Locale('pt', 'BR')],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Modular.generateRoute,
    );
  }
}
