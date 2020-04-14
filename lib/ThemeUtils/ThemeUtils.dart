import 'package:flutter/material.dart';

class ThemeUtils {
  // 默认主题色
  static const Color mainColor = const Color(0xFF63CA6C);

  // 可选的主题色
  static const List<Color> supportColors = [
    mainColor,
    Colors.purple,
    Colors.orange,
    Colors.deepPurpleAccent,
    Colors.redAccent,
    Colors.blue,
    Colors.amber,
    Colors.green,
    Colors.lime,
    Colors.indigo,
    Colors.cyan,
    Colors.teal
  ];

  // 当前的主题色
  static Color currentColor = mainColor;

}