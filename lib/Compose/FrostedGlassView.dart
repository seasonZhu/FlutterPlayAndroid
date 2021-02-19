import 'dart:ui';
import 'package:flutter/material.dart';

/// 毛玻璃效果
class FrostedGlassView extends StatelessWidget {
  final Widget child;

  const FrostedGlassView({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        BackdropFilter(
          /// 建议sigmaX与sigmaY参数都为5 这个效果最好
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Opacity(
            /// opacity为0.2,数值过大就完全遮挡了
            opacity: 0.2,
            child: Container(
              decoration: BoxDecoration(color: Colors.grey.shade200),
            ),
          ),
        ),
      ],
    );
  }
}
