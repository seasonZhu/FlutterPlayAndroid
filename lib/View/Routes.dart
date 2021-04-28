import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:play_android/My/RankingView.dart';
import 'package:play_android/My/MyDetailView.dart';
import 'package:play_android/My/MyCoinView.dart';
import 'package:play_android/My/MyCollectView.dart';
import 'package:play_android/My/ThemeSettingView.dart';
import 'package:play_android/My/AboutAppAndMeView.dart';

import 'package:play_android/Tree/TreeView.dart';

import 'package:play_android/Information/InformationFlowWebView.dart';

import 'package:play_android/Home/HotKeyView.dart';
import 'package:play_android/Home/SearchResultView.dart';

import 'package:play_android/Account/LoginView.dart';
import 'package:play_android/Account/RegisterView.dart';

import 'package:play_android/ExampleView/View/TodayHotNavigatorView.dart';
import 'package:play_android/ExampleView/View/MixinCountView.dart';
import 'package:play_android/ExampleView/View/NanigationRailView.dart';
import 'package:play_android/ExampleView/View/DismissibleView.dart';
import 'package:play_android/ExampleView/View/RoundView.dart';
import 'package:play_android/ExampleView/View/RankingStreamView.dart';
import 'package:play_android/ExampleView/View/RankingBlocView.dart';
import 'package:play_android/ExampleView/View/CalculatorView.dart';
import 'package:play_android/ExampleView/View/BlocExampleApp.dart';
import 'package:play_android/ExampleView/View/BottomDragView.dart';
import 'package:play_android/ExampleView/View/TiledLines.dart';
import 'package:play_android/ExampleView/View/PressLocationView.dart';
import 'package:play_android/ExampleView/View/DataLineView.dart';
import 'package:play_android/ExampleView/View/StarPath.dart';
import 'package:play_android/ExampleView/View/PathProviderView.dart';
import 'package:play_android/ExampleView/View/TweenAnimationView.dart';
import 'package:play_android/ExampleView/View/UpdateView.dart';
import 'package:play_android/ExampleView/View/RefreshIndicatorListView.dart';
import 'package:play_android/ExampleView/View/DoubleLoadingView.dart';
import 'package:play_android/ExampleView/View/UniAppNewsListView.dart';
import 'package:play_android/ExampleView/View/CarInputView.dart';

import 'package:play_android/Compose/ErrorView.dart';

/// 全局监听路由堆栈的变化使用 RouteObserve
RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

final navigationGlobalKey = GlobalKey<NavigatorState>();

// 路由表
abstract class Routes {
  // 系统默认'/'是根view,这个不能更改
  static const root = "/";

  // 使用const也是可以的
  static const rankingView = "/rankingView";

  static const informationFlowWebView = "/informationFlowWebView";

  static const hotKeyView = "/hotKeyView";

  static const searchResultView = "/searchResultView";

  static const myDetailView = "/myDetailView";

  static const myCoinView = "/myCoinView";

  static const myCollectView = "/myCollectView";

  static const themeSettingView = "/themeSettingView";

  static const tree = "/tree";

  static const aboutAppAndMeView = "/aboutAppAndMeView";

  static const loginView = "/loginView";

  static const registerView = "/registerView";

  static const todayHotNavigatorView = "/todayHotNavigatorView";

  static const mixinCountView = "/mixinCountView";

  static const nanigationRailView = "/nanigationRailView";

  static const dismissibleView = "/dismissibleView";

  static const roundView = "/roundView";

  static const rankingStreamView = "/rankingStreamView";

  static const rankingBlocView = "/rankingBlocView";

  static const calculatorView = "/calculatorView";

  static const blocExampleApp = "/blocExampleApp";

  static const bottomDragView = "/bottomDragView";

  static const tiledLines = "/tiledLines";

  static const pressLocationView = "/pressLocationView";

  static const dataLineView = "/dataLineView";

  static const startClip = "/startClip";

  static const pathProviderView = "/pathProviderView";

  static const tweenAnimationView = "/tweenAnimationView";

  static const updateView = "/updateView";

  static const refreshIndicatorListViewState = "/refreshIndicatorListViewState";

  static const doubleLoadingView = "/doubleLoadingView";

  static const uniAppNewsListView = "/uniAppNewsListView";

  static const carInputView = "/carInputView";

  // 路由需要传递的参数
  static var arguments;

  // 路由
  static Map<String, WidgetBuilder> maps() {
    return {
      // 首页路由
      Routes.hotKeyView: (context) => HotKeyView(),
      Routes.searchResultView: (context) => SearchResultView(
            keyword: arguments,
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
      Routes.tree: (context) => TreeView(),
      Routes.aboutAppAndMeView: (context) => AboutAppAndMeView(),

      // 测试页面的路由
      Routes.todayHotNavigatorView: (context) => TodayHotNavigatorView(),
      Routes.mixinCountView: (context) => MixinCountView(),
      Routes.nanigationRailView: (context) => NanigationRailView(),
      Routes.dismissibleView: (context) => DismissibleView(),
      Routes.roundView: (context) => RoundView(),
      Routes.rankingStreamView: (context) => RankingStreamView(),
      // Routes.rankingBlocView: (context) => BlocProvider(
      //       create: (_) => RankingBloc(),
      //       child: RankingBlocView(),
      //     ),
      Routes.calculatorView: (context) => CalculatorView(),
      // Routes.blocExampleApp: (context) => BlocExampleApp(),
      Routes.bottomDragView: (context) => BottomDragView(),
      Routes.tiledLines: (context) => TiledLines(),
      Routes.pressLocationView: (context) => PressLocationView(),
      Routes.dataLineView: (context) => DataLineView(),
      Routes.startClip: (context) => StartClip(),
      Routes.pathProviderView: (context) => PathProviderView(),
      Routes.tweenAnimationView: (context) =>
          CurvedAnimationView(), //TweenAnimationView(title: "简单的缩放动画",)
      Routes.updateView: (context) => UpdateView(),
      Routes.refreshIndicatorListViewState: (context) =>
          RefreshIndicatorListView(),
      Routes.doubleLoadingView: (context) => DoubleLoadingView(),
      Routes.uniAppNewsListView: (context) => UniAppNewsListView(),
      // Routes.carInputView: (context) => CarInputView(),
    };
  }

  static Route<dynamic> unknowMap(RouteSettings settings) {
    final name = settings.name;
    print("未匹配到路由$name");
    return MaterialPageRoute(
        builder: (context) => Scaffold(
              appBar: AppBar(
                title: Text("未知路由", style: TextStyle(color: Colors.white)),
                iconTheme: IconThemeData(color: Colors.white),
                elevation: 0.1,
              ),
              body: ErrorView(),
            ));
  }

  // 初始化方法私有化
  Routes._();
}
