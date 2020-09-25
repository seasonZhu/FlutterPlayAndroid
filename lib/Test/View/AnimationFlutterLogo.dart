import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

/// 从Flutter_deer里面抽出来的
class AnimationFlutterLogo extends StatefulWidget {
  final double size;

  AnimationFlutterLogo({Key key, this.size = 100}): super(key: key);

  @override
  _AnimationFlutterLogoState createState() => _AnimationFlutterLogoState();
}

class _AnimationFlutterLogoState extends State<AnimationFlutterLogo> {
  final _styles = [
    FlutterLogoStyle.stacked,
    FlutterLogoStyle.markOnly,
    FlutterLogoStyle.horizontal
  ];
  final _colors = [
    Colors.red,
    Colors.green,
    Colors.brown,
    Colors.blue,
    Colors.purple,
    Colors.pink,
    Colors.amber
  ];
  final _curves = [
    Curves.ease,
    Curves.easeIn,
    Curves.easeInOutCubic,
    Curves.easeInOut,
    Curves.easeInQuad,
    Curves.easeInCirc,
    Curves.easeInBack,
    Curves.easeInOutExpo,
    Curves.easeInToLinear,
    Curves.easeOutExpo,
    Curves.easeInOutSine,
    Curves.easeOutSine,
  ];

  // 取随机颜色
  Color _randomColor() {
    var red = Random.secure().nextInt(255);
    var greed = Random.secure().nextInt(255);
    var blue = Random.secure().nextInt(255);
    return Color.fromARGB(255, red, greed, blue);
  }

  Timer _countdownTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // 2s定时器
      _countdownTimer = Timer.periodic(Duration(seconds: 2), (timer) {
        // https://www.jianshu.com/p/e4106b829bff
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogo(
      size: widget.size,
      colors: _colors[Random.secure().nextInt(7)],
      textColor: _randomColor(),
      style: _styles[Random.secure().nextInt(3)],
      curve: _curves[Random.secure().nextInt(12)],
    );
  }
}
