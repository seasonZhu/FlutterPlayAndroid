import 'package:flutter/material.dart';

//import 'package:fluwx/fluwx.dart';

import 'package:play_android/ThemeUtils/ThemeUtils.dart';
import 'MainView.dart';
import 'SplashView.dart';

import 'Routes.dart';
import 'package:play_android/EventBus/EventBus.dart';

import 'package:play_android/My/RankingView.dart';
import 'package:play_android/My/MyDetailView.dart';
import 'package:play_android/My/MyCoinView.dart';
import 'package:play_android/My/MyCollectView.dart';
import 'package:play_android/My/ThemeSettingView.dart';
import 'package:play_android/My/AboutAppAndMeView.dart';

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

class _PlayAndroidAppState extends State<PlayAndroidApp> {
  var themeColor = ThemeUtils.currentColor;

  var themeBrightness = Brightness.light;

  @override
  void initState() {
    super.initState();

    _themeColorListener();
    _themeModeListener();

    // 微信SDK注册 这里只是一个例子,实际还要做双端的配置
    //registerWxApi(appId: "",universalLink: "");
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Play Android',
      theme: _themeData(),
      home: SplashView(),
      routes: _routes(),
    );
  }

  // 路由
  Map<String, WidgetBuilder> _routes() {
    return {
      // 首页路由
      Routes.hotKeyView: (context) => HotKeyView(),
      Routes.searchResultView: (context) => SearchResultView(
            keyword: PlayAndroidApp.any,
          ),

      // 项目和公众号路由
      Routes.informationFlowWebView: (context) => InformationFlowWebView(),

      // 登录与注册路由
      Routes.loginView: (context) => LoginView(),
      Routes.registerView: (context) => RegisterView(),

      // 我的路由
      Routes.rankingView: (context) => RankingView(),
      Routes.myDetailView: (context) => MyDetailView(),
      Routes.myCoinView: (context) => MyCoinView(),
      Routes.myCollectView: (context) => MyCollectView(),
      Routes.themeSettingView: (context) => ThemeSettingView(),
      Routes.aboutAppAndMeView: (context) => AboutAppAndMeView(),
    };
  }

  void _themeColorListener() {
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

  void _themeModeListener() {
    AccountManager.getInstance().getIsOpenDardMode().then((isOpenDarkMode) {
      eventBus.fire(ChangeThemeBrightness(
          isOpenDarkMode ? Brightness.dark : Brightness.light));
    });

    eventBus.on<ChangeThemeBrightness>().listen((event) {
      setState(() {
        themeBrightness = event.brightnessType;
      });
    });
  }

  // 主题数据
  ThemeData _themeData() {
    switch (themeBrightness) {
      case Brightness.dark:
        return ThemeData.dark();
        break;
      case Brightness.light:
        return ThemeData(
            primaryColor: themeColor,
            platform: TargetPlatform.iOS,
            brightness: Brightness.light);
        break;
      default:
        return ThemeData(
            primaryColor: themeColor,
            platform: TargetPlatform.iOS,
            brightness: Brightness.light);
        break;
    }
  }
}
