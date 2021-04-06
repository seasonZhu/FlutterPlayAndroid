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

import 'package:play_android/Test/View/TodayHotNavigatorView.dart';
import 'package:play_android/Test/View/MixinCountView.dart';
import 'package:play_android/Test/View/NanigationRailView.dart';
import 'package:play_android/Test/View/DismissibleView.dart';
import 'package:play_android/Test/View/RoundView.dart';
import 'package:play_android/Test/View/RankingStreamView.dart';
import 'package:play_android/Test/View/RankingBlocView.dart';
import 'package:play_android/Test/View/CalculatorView.dart';
import 'package:play_android/Test/View/BlocExampleApp.dart';
import 'package:play_android/Test/View/BottomDragView.dart';
import 'package:play_android/Test/View/TiledLines.dart';
import 'package:play_android/Test/View/PressLocationView.dart';
import 'package:play_android/Test/View/DataLineView.dart';
import 'package:play_android/Test/View/StarPath.dart';
import 'package:play_android/Test/View/PathProviderView.dart';
import 'package:play_android/Test/View/TweenAnimationView.dart';
import 'package:play_android/Test/View/UpdateView.dart';
import 'package:play_android/Test/View/RefreshIndicatorListView.dart';
import 'package:play_android/Test/View/DoubleLoadingView.dart';
import 'package:play_android/Test/View/UniAppNewsListView.dart';

import 'package:play_android/Compose/ErrorView.dart';

/// 全局监听路由堆栈的变化使用 RouteObserve
RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

final navigationGlobalKey = new GlobalKey<NavigatorState>();

// 路由表
abstract class Routes {
  // 系统默认'/'是根view,这个不能更改
  static final root = "/";

  // 使用const也是可以的
  static final rankingView = "/rankingView";

  static final informationFlowWebView = "/informationFlowWebView";

  static final hotKeyView = "/hotKeyView";

  static final searchResultView = "/searchResultView";

  static final myDetailView = "/myDetailView";

  static final myCoinView = "/myCoinView";

  static final myCollectView = "/myCollectView";

  static final themeSettingView = "/themeSettingView";

  static final tree = "/tree";

  static final aboutAppAndMeView = "/aboutAppAndMeView";

  static final loginView = "/loginView";

  static final registerView = "/registerView";

  static final todayHotNavigatorView = "/todayHotNavigatorView";

  static final mixinCountView = "/mixinCountView";

  static final nanigationRailView = "/nanigationRailView";

  static final dismissibleView = "/dismissibleView";

  static final roundView = "/roundView";

  static final rankingStreamView = "/rankingStreamView";

  static final rankingBlocView = "/rankingBlocView";

  static final calculatorView = "/calculatorView";

  static final blocExampleApp = "/blocExampleApp";

  static final bottomDragView = "/bottomDragView";

  static final tiledLines = "/tiledLines";

  static final pressLocationView = "/pressLocationView";

  static final dataLineView = "/dataLineView";

  static final startClip = "/startClip";

  static final pathProviderView = "/pathProviderView";

  static final tweenAnimationView = "/tweenAnimationView";

  static final updateView = "/updateView";

  static final refreshIndicatorListViewState = "/refreshIndicatorListViewState";

  static final doubleLoadingView = "/doubleLoadingView";

  static final uniAppNewsListView = "/uniAppNewsListView";

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
