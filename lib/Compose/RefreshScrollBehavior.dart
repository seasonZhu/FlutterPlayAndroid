import 'package:flutter/material.dart';

class RefreshScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
        return child;
      case TargetPlatform.macOS:
      case TargetPlatform.android:
        return GlowingOverscrollIndicator(
          child: child,
          showLeading: false, //顶部水波纹是否展示
          showTrailing: false, //底部水波纹是否展示
          axisDirection: axisDirection,
          notificationPredicate: (notification) {
            if (notification.depth == 0) {
              // 越界是否展示水波纹
              if (notification.metrics.outOfRange) {
                return false;
              }
              return true;
            }
            return false;
          },
          color: Theme.of(context).primaryColor,
        );
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return null;
    }
    return null;
  }
}
