import 'dart:async';
import 'package:flutter/material.dart';

import 'package:play_android/Compose/CustomRoute.dart';
import 'MainView.dart';

// 这里其实是模拟的一个广告页面
class SplashView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashViewState();
  }
}

class _SplashViewState extends State<SplashView> {

  Timer _timer;
  int seconds = 5;

    @override
  void initState() {
    super.initState();
    //countDown();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: <Widget>[
          Container(),
          Positioned(
            right: 20,
            top: 40,
            child: FlatButton(
              child: Text("跳过$seconds" + "s"),
              color: Colors.grey,
              shape: RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              onPressed: () {
                _goMainView();
              },
            )
          ),
        ],
      )
    );
  }

  // 延时执行
  void countDown() {
    var duration = Duration(seconds: 1);
    Future.delayed(duration, _goMainView);
  }

  _goMainView() {
    Navigator.pushAndRemoveUntil(
      context,
      CustomRoute(type: TransitionType.fade, widget: MainView()),
      (route) => route == null,
    );
  }

  // 倒计时执行
  void startTimer() {
    //设置 1 秒回调一次
    const period = const Duration(seconds: 1);
    _timer = Timer.periodic(period, (timer) {
      //更新界面
      setState(() {
        //秒数减一，因为一秒回调一次
        seconds--;
      });
      if (seconds == 0) {
        //倒计时秒数为0，取消定时器
        cancelTimer();
        _goMainView();
      }
    });
  }

  void cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  @override
  void dispose() {
    super.dispose();
    cancelTimer();
  }
}
