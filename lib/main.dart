import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'View/PlayAndroidApp.dart';
import 'package:play_android/ExampleView/View/TestKeyboard.dart';

void main() => run();

run() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  TestKeyboard.register();

  runApp(PlayAndroidApp());
}
