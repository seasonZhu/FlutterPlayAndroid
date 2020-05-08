import 'dart:async';
import 'package:flutter/material.dart';

import 'package:play_android/Compose/CustomRoute.dart';
import 'MainView.dart';

class SplashView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashViewState();
  }
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        //设置背景图片
        image: DecorationImage(
          image: AssetImage("assets/images/launchImage.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    countDown();
  }

// 倒计时
  void countDown() {
    var duration = Duration(seconds: 1);
    new Future.delayed(duration, _goMainView);
  }

  _goMainView() {
    Navigator.pushAndRemoveUntil(
      context,
      CustomRoute(type: TransitionType.fade, widget: MainView()),
          (route) => route == null,
    );
  }
}