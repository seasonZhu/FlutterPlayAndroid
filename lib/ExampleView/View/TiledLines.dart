import 'dart:math';
import 'package:flutter/material.dart';

class TiledLines extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<BoxShadow> shadows = [];
    double opacity = 0.1;

    // 添加画布阴影
    for (double i = 1; i <= 16; i++) {
      opacity -= 0.01;
      opacity = opacity > 0.01 ? opacity : 0.01;

      shadows.add(
        BoxShadow(
          offset: Offset(-i, i),
          color: Color.fromRGBO(0, 0, 0, opacity),
          blurRadius: 2,
          spreadRadius: 1,
        ),
      );
    }

    return Scaffold(
      body: Center(
        child: Container(
          width: 320.0,
          height: 320.0,
          decoration: BoxDecoration(
            // 添加画布边框
            border: Border.all(
              color: Colors.black,
              width: 20.0,
            ),
            boxShadow: shadows,
          ),
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20.0),
            child: CustomPaint(
              painter: TiledLinesPainter(20),
            ),
          ),
        ),
      ),
    );
  }
}

class TiledLinesPainter extends CustomPainter {
  final double step;

  TiledLinesPainter(this.step);

  void _drawLine(
    Canvas canvas,
    double x,
    double y,
    double width,
    double height,
  ) {
    // 创建随机性
    final bool isLeftToRight = Random().nextBool();

    final Paint paint = Paint()
      ..strokeCap = StrokeCap.square
      ..strokeWidth = 2;

    Offset p1;
    Offset p2;

    // 设置线条的起始点和终止点
    if (isLeftToRight) {
      p1 = Offset(x, y);
      p2 = Offset(x + width, y + height);
    } else {
      p1 = Offset(x + width, y);
      p2 = Offset(x, y + height);
    }

    canvas.drawLine(p1, p2, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    // 使用 step 分割画布，创建小的绘制方格
    for (double x = 0; x < size.width; x += step) {
      for (double y = 0; y < size.height; y += step) {
        _drawLine(canvas, x, y, step, step);
      }
    }
  }

  bool shouldRepaint(TiledLinesPainter oldDelegate) => false;
}