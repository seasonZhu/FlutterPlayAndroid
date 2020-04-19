import 'package:flutter/material.dart';

import 'package:play_android/ThemeUtils/ThemeUtils.dart';
import 'MainView.dart';

import 'Routes.dart';
import 'package:play_android/EventBus/EventBus.dart';

import 'package:play_android/My/AboutAppAndMeView.dart';
import 'package:play_android/My/RankingView.dart';
import 'package:play_android/My/ThemeSettingView.dart';
import 'package:play_android/My/MyCoinView.dart';

import 'package:play_android/Information/InformationFlowWebView.dart';

import 'package:play_android/Home/HotKeyView.dart';
import 'package:play_android/Home/SearchResultView.dart';

import 'package:play_android/Account/LoginView.dart';
import 'package:play_android/Account/RegisterView.dart';
import 'package:play_android/Account/AccountManager.dart';

class PlayAndroidApp extends StatefulWidget {
  static var any;

  @override
  _PlayAndroidAppState createState() => _PlayAndroidAppState();
}

class _PlayAndroidAppState extends State<PlayAndroidApp>  {
  Color themeColor = ThemeUtils.currentColor;

  @override
  void initState() {
    super.initState();

    // 我一直都很喜欢用await 这个算是第一次使用then然后在闭包中进行计算
    AccountManager.getInstance().getLastThemeSettingIndex().then((index) {
      ThemeUtils.currentColor = ThemeUtils.supportColors[index];
      eventBus.fire(ChangeThemeEvent(ThemeUtils.supportColors[index]));
    });

    eventBus.on<ChangeThemeEvent>().listen((event) {
      setState(() {
        themeColor = event.color;
      });
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Play Android',
      theme: ThemeData(
        primaryColor: themeColor,
        platform: TargetPlatform.iOS, 
      ),
      home: MainView(),
      routes: {
        Routes.rankingView: (context) => RankingView(),
        Routes.informationFlowWebView: (context) => InformationFlowWebView(),
        Routes.hotKeyView: (context) => HotKeyView(),
        Routes.searchResultView: (context) => SearchResultView(keyword: PlayAndroidApp.any,),
        Routes.themeSettingView: (context) => ThemeSettingView(),
        Routes.aboutAppAndMeView: (context) => AboutAppAndMeView(),
        Routes.loginView: (context) => LoginView(),
        Routes.registerView: (context) => RegisterView(),
        Routes.myCoinView: (context) => MyCoinView(),
      },
    );
  }
}
