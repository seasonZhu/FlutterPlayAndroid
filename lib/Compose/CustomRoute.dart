import 'package:flutter/material.dart';

class CustomRoute extends PageRouteBuilder {
  final Widget widget;

  final TransitionType type;

  CustomRoute({this.widget, this.type})
      : super(
        // 设置过度时间
        transitionDuration: Duration(seconds: 1),
        // 构造器
        pageBuilder: (
          // 上下文和动画
          BuildContext context,
          Animation<double> animaton1,
          Animation<double> animaton2,
        ) {
          return widget;
        },
        transitionsBuilder: (
          BuildContext context,
          Animation<double> animaton1,
          Animation<double> animaton2,
          Widget child,
        ) {
          var aimationWidget;
          switch (type) {
            case TransitionType.fade:
              aimationWidget = FadeTransition(
                // 从0开始到1
                opacity:
                    Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                  // 传入设置的动画
                  parent: animaton1,
                  // 设置效果，快进漫出   这里有很多内置的效果
                  curve: Curves.fastOutSlowIn,
                )),
                child: child,
              );
              break;
            case TransitionType.scale:
              // 缩放动画效果
              aimationWidget = ScaleTransition(
                scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                    parent: animaton1, curve: Curves.fastOutSlowIn)),
                child: child,
              );
              break;
            case TransitionType.rotation:
              // 旋转加缩放动画效果
              aimationWidget = RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                  parent: animaton1,
                  curve: Curves.fastOutSlowIn,
                )),
                child: ScaleTransition(
                  scale: Tween(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                          parent: animaton1, curve: Curves.fastOutSlowIn)),
                  child: child,
                ),
              );
              break;
            case TransitionType.slide:
              // 左右滑动动画效果
              aimationWidget = SlideTransition(
                position: Tween<Offset>(
                        // 设置滑动的 X , Y 轴
                        begin: Offset(-1.0, 0.0),
                        end: Offset(0.0, 0.0))
                    .animate(CurvedAnimation(
                        parent: animaton1, curve: Curves.fastOutSlowIn)),
                child: child,
              );
              break;
          }
          return aimationWidget;
        }
      );
}

enum TransitionType {
  fade,
  scale,
  rotation,
  slide,
}