import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//import 'View/BlocExampleApp.dart';
import 'View/PlayAndroidApp.dart';

void main() {
  // 强制竖屏
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(PlayAndroidApp());
}


