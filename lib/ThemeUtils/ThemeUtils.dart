import 'package:flutter/material.dart';

class ThemeUtils {
  // 默认主题色 iOS的开发者下的系统蓝
  static const Color mainColor = const Color.fromARGB(255, 28, 135, 251);

  // 可选的主题色
  static const List<Color> supportColors = [
    mainColor,
    Colors.purple,
    Colors.orange,
    Colors.deepPurpleAccent,
    Colors.redAccent,
    Colors.amber,
    Color(0xFF63CA6C),
    Colors.lime,
    Colors.indigo,
    Colors.cyan,
    Colors.teal
  ];

  // 当前的主题色
  static Color currentColor = mainColor;

}