import 'package:flutter/material.dart';

class StrokeContainer extends StatelessWidget {
  final Color color;
  final Widget child;
  final EdgeInsets edgeInsets;
  final double strokeWidth;
  final double strokeRadius;

  StrokeContainer(
      {Key key,
      @required this.child,
      this.color = Colors.black,
      this.edgeInsets = const EdgeInsets.all(0),
      this.strokeWidth = 1.0,
      this.strokeRadius = 5.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: edgeInsets,
        decoration: BoxDecoration(
            border: Border.all(color: color, width: strokeWidth),
            borderRadius: BorderRadius.circular(strokeRadius)),
        child: child);
  }
}
