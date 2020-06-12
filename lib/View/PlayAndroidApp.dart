import 'package:flutter/material.dart';

//import 'package:fluwx/fluwx.dart';

import 'package:play_android/ThemeUtils/ThemeUtils.dart';
import 'WelcomeView.dart';
import 'SplashView.dart';
import 'Routes.dart';
import 'package:play_android/EventBus/EventBus.dart';
import 'package:play_android/Account/AccountManager.dart';
import 'package:play_android/DeviceSize/DeviceSize.dart';

class PlayAndroidApp extends StatefulWidget {
  
  @override
  _PlayAndroidAppState createState() => _PlayAndroidAppState();
}

class _PlayAndroidAppState extends State<PlayAndroidApp> {
  var themeColor = ThemeUtils.currentColor;

  var themeBrightness = Brightness.light;

  Widget _home = Container(
          width: 1080,
          height: 1920,
          decoration: BoxDecoration(
            //设置背景图片
            image: DecorationImage(
              image: AssetImage("assets/images/launchImage.png"),
              fit: BoxFit.cover,
            ),
          ),
      );

  @override
  void initState() {
    super.initState();
    _homeView();
    _themeColorListener();
    _themeModeListener();

    // 微信SDK注册 这里只是一个例子,实际还要做双端的配置
    //registerWxApi(appId: "",universalLink: "");
  }

  Widget build(BuildContext context) {
    // MaterialApp初始化之前使用context获取屏幕的信息也是也没有意义的,会报错,但是可以获取平台信息
    var platform = Theme.of(context).platform;
    print(platform);
    _sizeInfo();
    return MaterialApp(
      title: 'Play Android',
      theme: _themeData(),
      home: _home,
      routes: Routes.maps(),
      onUnknownRoute: Routes.unknowMap,
    );
  }

  void _sizeInfo() {
    print("状态栏高度: ${DeviceSize.statusBarHeight}");
    print("底部间距: ${DeviceSize.bottomPadding}");
    print("屏幕宽高: ${DeviceSize.screenWidth} * ${DeviceSize.screenHeight}");
    print("屏幕物理宽高: ${DeviceSize.physicalWidth} * ${DeviceSize.physicalHeight}");
    print("屏幕系数: ${DeviceSize.dpr}");
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

  void _homeView() async {
    AccountManager.getInstance().getIsFirstLaunch().then((isFirstLaunch) {
      setState(() {
        _home = isFirstLaunch ? WelcomeView() : SplashView();
      });
    }); 
  }
}
