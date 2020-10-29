import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'View/PlayAndroidApp.dart';

void main() => run();

/*
注释插件的使用
!警告
? 疑问
* 参数
TODO: 去干什么
 */
run() {
  // 强制竖屏
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(PlayAndroidApp());
}
