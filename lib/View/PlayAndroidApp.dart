import 'package:flutter/material.dart';

import 'package:play_android/ThemeUtils/ThemeUtils.dart';
import 'MainView.dart';

class PlayAndroidApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Play Android',
      theme: ThemeData(
        primaryColor: ThemeUtils.currentColor,
        platform: TargetPlatform.iOS, 
      ),
      home: MainView(),
    );
  }
}