import 'dart:math';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:zapiti_desafio/app/modules/home/modules/init/model/news.dart';


import 'item_list_news.dart';

class MyAutoPage extends StatefulWidget {
  final List<News> listNews;

  MyAutoPage(this.listNews);

  @override
  _MyAutoPageState createState() => _MyAutoPageState();
}

class _MyAutoPageState extends State<MyAutoPage>
    with SingleTickerProviderStateMixin {
  List colors = [Colors.red, Colors.green, Colors.yellow];

  AnimationController _animationController;
  Animation<double> _nextPage;
  int _currentPage = 0;
  PageController _pageController = PageController(
    initialPage: 0,
    viewportFraction: 0.9,
  );

  @override
  void initState() {
    super.initState();

    /// Comece no controlador e defina a hora para mudar de página
    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 10));
    _nextPage = Tween(begin: 0.0, end: 1.0).animate(_animationController);

    /// Adicionar ouvinte ao AnimationController para saber quando terminar a contagem e passar para a próxima página
    _animationController.addListener(() {
      if (_animationController.status == AnimationStatus.completed) {
        _animationController.reset();
        final int page = widget.listNews.length;
        if (_currentPage < page) {
          _currentPage++;
          _pageController.animateToPage(_currentPage,
              duration: Duration(milliseconds: 300), curve: Curves.easeInSine);
        }
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();
    print(_nextPage.value);
    return PageView.builder(
        itemCount: widget.listNews.length,
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        onPageChanged: (value) {
          if (value >= widget.listNews.length) {
            setState(() {
              _currentPage = 0;
            });
            SchedulerBinding.instance.addPostFrameCallback((_) {
              _pageController.jumpTo(0);
            });
          } else {
            _animationController.forward();
          }
        },
        itemBuilder: (BuildContext context, int index) {
          var randomColor = Color((Random().nextDouble() * 0xFFFFFF).toInt());
          return Container(
            color: randomColor.withOpacity(1.0),
            width: 500,
            child: ItemListNews(widget.listNews[index],index),
          );
        });
  }
}
