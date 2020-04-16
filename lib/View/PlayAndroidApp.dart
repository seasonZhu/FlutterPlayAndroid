import 'package:flutter/material.dart';

import 'package:play_android/ThemeUtils/ThemeUtils.dart';
import 'MainView.dart';

import 'Routes.dart';
import 'package:play_android/My/RankingView.dart';
import 'package:play_android/Information/InformationFlowWebView.dart';
import 'package:play_android/Home/HotKeyView.dart';
import 'package:play_android/Home/SearchResultView.dart';

class PlayAndroidApp extends StatelessWidget {

  static var any;

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Play Android',
      theme: ThemeData(
        primaryColor: ThemeUtils.currentColor,
        platform: TargetPlatform.iOS, 
      ),
      home: MainView(),
      routes: {
        Routes.rankingView: (context) => RankingView(),
        Routes.informationFlowWebView: (context) => InformationFlowWebView(),
        Routes.hotKeyView: (context) => HotKeyView(),
        Routes.searchResultView: (context) => SearchResultView(keyword: any,),
      },
    );
  }
}
