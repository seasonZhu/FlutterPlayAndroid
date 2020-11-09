import 'package:flutter/material.dart';

//import 'package:fluwx/fluwx.dart';
//import 'package:connectivity/connectivity.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:play_android/ThemeUtils/ThemeUtils.dart';
import 'WelcomeView.dart';
import 'SplashView.dart';
import 'Routes.dart';
import 'package:play_android/EventBus/EventBus.dart';
import 'package:play_android/Account/AccountManager.dart';
import 'package:play_android/SystemConfig/DeviceSize.dart';

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
    _networkListener();
    // 微信SDK注册 这里只是一个例子,实际还要做双端的配置
    //registerWxApi(appId: "",universalLink: "");
  }

  Widget build(BuildContext context) {
    // MaterialApp初始化之前使用context获取屏幕的信息也是也没有意义的,会报错,但是可以获取平台信息
    var platform = Theme.of(context).platform;
    print(platform);
    _sizeInfo();
    return MaterialApp(
        navigatorKey: navigationGlobalKey,
        title: 'Play Android',
        theme: _themeData(),
        home: _home,
        /// builder的使用
        builder: (BuildContext context, Widget child) {
          /// 确保 loading 组件能覆盖在其他组件之上.
          return FlutterEasyLoading(child: child);
        },
        /// 去掉全局的上下拉 水波纹效果
      
        // builder: (context, child) {
        //     child= ScrollConfiguration(
        //       child:  child,
        //       behavior: RefreshScrollBehavior(),
        //     );
        //     return child;
        // },
        routes: Routes.maps(),
        navigatorObservers: [routeObserver],
        onUnknownRoute: Routes.unknowMap,
        // 注意onGenerateRoute和onUnknownRoute都是RouteFactory类型 typedef RouteFactory = Route<dynamic> Function(RouteSettings settings);
        onGenerateRoute: (settings) {
          // Handle '/'
          if (settings.name == '/') {
            return MaterialPageRoute(builder: (context) => SplashView());
          }

          // Handle '/details/:id'典型的路由
          var uri = Uri.parse(settings.name);
          if (uri.pathSegments.length == 2 &&
              uri.pathSegments.first == 'details') {
            var _ = uri.pathSegments[1];
            return MaterialPageRoute(builder: (context) => SplashView());
          }

          return Routes.unknowMap(settings);
        });
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

  void _networkListener() {
    // 实时监听
    // var subscription = Connectivity()
    //     .onConnectivityChanged
    //     .listen((ConnectivityResult result) {
    //   ToastView.show(result.toString());
    //   print(result);
    // });
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
