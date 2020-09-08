import 'dart:math';

import 'package:flutter/material.dart';

/// 一个可以自适应的安卓菊花转
class MaterialProgressIndicator extends StatelessWidget {
  const MaterialProgressIndicator({this.size, this.color = Colors.white});

  final Size size;

  final Color color;

  get _length => min(size.width, size.height);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _length,
      height: _length,
      child: FittedBox(
        fit: BoxFit.contain,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }
}
