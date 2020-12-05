import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:zapiti_desafio/app/modules/splash/funny/splash_funny_page.dart';
import 'package:zapiti_desafio/app/utils/theme/app_theme_utils.dart';

Function _customFunction;
String _imagePath;
String _versionCode = "v-0.0.1-Alpha";
int _duration;

class AnimatedSplash extends StatefulWidget {
  AnimatedSplash(
      {@required String imagePath, Function customFunction, int duration}) {
    assert(duration != null);

    assert(imagePath != null);

    _duration = duration;
    _customFunction = customFunction;
    _imagePath = imagePath;
  }

  @override
  _AnimatedSplashState createState() => _AnimatedSplashState();
}

class _AnimatedSplashState extends State<AnimatedSplash>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;
  Timer _timer;
  int _start = 5;

  @override
  void initState() {
    super.initState();

    if (_duration < 1000) _duration = 2000;
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 800));
    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInCirc));
    _animationController.forward();
    startTimer();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
             _customFunction();
            timer?.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _timer?.cancel();
    _animationController.reset();
  }

  @override
  Widget build(BuildContext context) {
    // !kIsWeb
    //     ? Future.delayed(Duration(milliseconds: 800)).then((value) {
    //         Future.delayed(Duration(milliseconds: _duration)).then((value) {
    //           _customFunction();
    //         });
    //       })
    //     : Future.delayed(Duration.zero).then((value) {
    //         _customFunction();
    //       });

    return Scaffold(
        body: Container(
            color: AppThemeUtils.colorPrimary,
            child: Stack(children: [
              FadeTransition(
                  opacity: _animation,
                  child: Center(
                      child: Container(
                          height: 250.0,
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Image.asset(_imagePath)))),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: "Desenvolvido ",
                                    style: AppThemeUtils.normalSize(
                                        color: AppThemeUtils.whiteColor,
                                        fontSize: 16),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: "por ",
                                          style: AppThemeUtils.normalSize(
                                              fontSize: 16,
                                              color: AppThemeUtils.darkGray)),
                                      TextSpan(
                                          text: "Nathan R. V. ",
                                          style: AppThemeUtils.normalSize(
                                              fontSize: 16,
                                              color: AppThemeUtils
                                                  .colorSecundary)),
                                      TextSpan(
                                          text: "Oliveira",
                                          style: AppThemeUtils.normalSize(
                                              fontSize: 16,
                                              color: AppThemeUtils.black)),
                                    ],
                                  ))),
                          Text(
                            _versionCode ?? "",
                            style: AppThemeUtils.normalSize(
                                fontSize: 16,
                                color: AppThemeUtils.colorSecundary),
                          ),
                        ],
                      ))),
              Align(
                  alignment: Alignment.topCenter,
                  child: SafeArea(
                      child: Container(
                          margin: EdgeInsets.all(20),
                          child: RichText(
                              text: TextSpan(
                            text: "Vorê sera redirecionado em $_start",
                            style: AppThemeUtils.normalSize(
                                color: AppThemeUtils.black, fontSize: 10),
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' ou ',
                                  style: AppThemeUtils.normalSize(
                                      color: AppThemeUtils.black,
                                      fontSize: 12)),
                              TextSpan(
                                  text: "Clique aqui",
                                  style: AppThemeUtils.normalSize(
                                      color: AppThemeUtils.whiteColor,
                                      decoration: TextDecoration.underline,
                                      fontSize: 12),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Modular.to.pushReplacement(
                                          new MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return SplashFunnyPage();
                                        },
                                      ));
                                    }),
                              TextSpan(
                                  text: ' Bonus ',
                                  style: AppThemeUtils.normalSize(
                                      color: AppThemeUtils.black, fontSize: 8)),
                            ],
                          ))))),
            ])));
  }
}
