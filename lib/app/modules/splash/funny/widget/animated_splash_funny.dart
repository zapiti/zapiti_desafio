import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zapiti_desafio/app/utils/theme/app_theme_utils.dart';



Function _customFunction;
String _imagePath;
String _versionCode = "v-000000000";
int _duration;

class AnimatedSplashFunny extends StatefulWidget {
  AnimatedSplashFunny(
      {@required String imagePath,
        Function customFunction,
        int duration}) {
    assert(duration != null);

    assert(imagePath != null);

    _duration = duration;
    _customFunction = customFunction;
    _imagePath = imagePath;

  }

  @override
  _AnimatedSplashFunnyState createState() => _AnimatedSplashFunnyState();
}

class _AnimatedSplashFunnyState extends State<AnimatedSplashFunny>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();

    if (_duration < 1000) _duration = 2000;
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 800));
    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInCirc));
    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.reset();
  }

  @override
  Widget build(BuildContext context) {
    !kIsWeb
        ? Future.delayed(Duration(milliseconds: 3000)).then((value) {
      Future.delayed(Duration(milliseconds: _duration)).then((value) {
        _customFunction();
      });
    })
        : Future.delayed(Duration.zero).then((value) {
      _customFunction();
    });

    return Scaffold(
        backgroundColor:
        kIsWeb ? AppThemeUtils.whiteColor : AppThemeUtils.colorPrimary,
        body: Stack(
          children: [
            FadeTransition(
                opacity: _animation,
                child: Center(
                    child: Container(
                        height: 250.0,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Image.asset(_imagePath)))),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text(
                    _versionCode ?? "",
                    style: AppThemeUtils.normalSize(
                        fontSize: 16, color: AppThemeUtils.whiteColor),
                  ),
                )),
          ],
        ));
  }
}
