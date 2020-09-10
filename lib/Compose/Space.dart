import 'package:flutter/material.dart';

/// 如果你使用过SwiftUI,一定会发现这是我夹带的私货,对于布局有一定的帮助 其实系统有Spacer这个控件
class Space extends StatelessWidget {

  final int _flex;

  Space({Key key, int flex = 1}):
    _flex = flex,
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(), flex: _flex);
  }
}