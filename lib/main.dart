import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'View/PlayAndroidApp.dart';

void main() => run();

run() {
  
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(PlayAndroidApp());
}
