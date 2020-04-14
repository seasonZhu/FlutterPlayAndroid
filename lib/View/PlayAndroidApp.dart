import 'package:flutter/material.dart';

import 'package:play_android/ThemeUtils/ThemeUtils.dart';
import 'MainView.dart';

import 'package:play_android/My/RankingView.dart';

class PlayAndroidApp extends StatelessWidget {

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Play Android',
      theme: ThemeData(
        primaryColor: ThemeUtils.currentColor,
        platform: TargetPlatform.iOS, 
      ),
      home: MainView(),
      routes: {
        '/RankingView': (context) => RankingView(),
      },
    );
  }
}