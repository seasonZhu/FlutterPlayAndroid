import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';

class AlarmPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AlarmPageState();
  }
}

class _AlarmPageState extends State<AlarmPage> {
  Timer _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            painter: DialPlate(context, Color.fromARGB(255, 70, 0, 144),
                Color.fromARGB(255, 121, 83, 254)),
          ),
        ],
      ),
    );
  }
}

class DialPlate extends CustomPainter {
  Paint _paintDial;
  Paint _paintGradient;
  double _radius;
  double _screenWidth; //屏幕宽度
  double _screenHeight; //屏幕高度

  int _numPoint = 24;
  ParagraphBuilder _timeParagraphBuilder;
  Color _startColor;
  Color _endColor;

  DialPlate(BuildContext context, Color startColor, Color endColor) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;

    _radius = _screenWidth / 100 * 37; //圆形的半径是宽度的37%
    _startColor = startColor;
    _endColor = endColor;

    _paintDial = Paint()
      ..color = Colors.white
      ..isAntiAlias = true
      ..style = PaintingStyle.fill; //初始化画笔

    //背景绘制区域，绘制的圆形半径是屏幕高度
    var circle = Rect.fromCircle(center: Offset(0, 0), radius: _screenHeight);

    //渐变
    var sweepGradient = SweepGradient(colors: [_startColor, _endColor]);

    //设置到画笔上
    _paintGradient = Paint()
      ..isAntiAlias = true
      ..shader = sweepGradient.createShader(circle)
      ..style = PaintingStyle.fill;

    //中间文字
    _timeParagraphBuilder = ParagraphBuilder(ParagraphStyle(
        textAlign: TextAlign.center,
        fontSize: 70,
        maxLines: 1,
        fontWeight: FontWeight.bold));
  }

  @override
  void paint(Canvas canvas, Size size) {
    //获取当前时间
    DateTime dateTime = DateTime.now();
    var hour = dateTime.hour;
    var minute = dateTime.minute;
    var second = dateTime.second;

    //设置背景的偏移
    canvas.translate(_screenWidth / 2, _screenHeight / 100 * 35);

    //绘制背景
    canvas.save();
    //设置背景的旋转角度
    canvas.rotate(_getRotate(second));
    canvas.drawCircle(Offset(0, 0), _screenHeight, _paintGradient);
    canvas.restore();

    //画一圈小圆点
    canvas.save();
    for (double i = 0; i < _numPoint; i++) {
      canvas.save();
      double deg = 360 / _numPoint * i;
      //画一个点转动一下画布
      canvas.rotate(deg / 180 * pi);
      if (isShowBigCircle(hour, i)) {
        Path path = Path()
          ..addArc(Rect.fromCircle(center: Offset(_radius, 0), radius: 8), 0,
              pi * 2);
        canvas.drawShadow(path, Colors.yellow, 4, true);
        _paintDial.color = Colors.yellow;
        canvas.drawCircle(Offset(_radius, 0), 8, _paintDial);
      } else {
        _paintDial.color = Colors.white;
        canvas.drawCircle(Offset(_radius, 0), 3, _paintDial);
      }
      canvas.restore();

      //画中间的时间文字
      canvas.save();
      _timeParagraphBuilder.addText(_getTimeStr(hour, minute));
      Paragraph paragraph = _timeParagraphBuilder.build();
      paragraph.layout(ParagraphConstraints(width: 230));
      canvas.drawParagraph(paragraph, Offset(-115, -42));
      canvas.restore();
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  double _getRotate(int second) {
    var anglePer = pi * 2 / 60;
    var diff = second - 15;
    return diff * anglePer;
  }

  //当前时针指向的圆点，是大圆点
  bool isShowBigCircle(int hour, double i) {
    if (hour >= 12) hour = hour - 12;
    int numHour = hour * 2 + 18;
    if (numHour < 24) {
      return i == numHour;
    } else {
      return i == (numHour - 24);
    }
  }

  //时间格式化str
  String _getTimeStr(int hour, int minute) {
    String hourStr;
    String minuteStr;
    if (hour < 10) {
      hourStr = '0$hour';
    } else {
      hourStr = hour.toString();
    }
    if (minute < 10) {
      minuteStr = '0$minute';
    } else {
      minuteStr = minute.toString();
    }
    return '$hourStr:$minuteStr';
  }
}
