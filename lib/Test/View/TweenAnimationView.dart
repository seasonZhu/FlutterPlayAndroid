import 'package:flutter/material.dart';

class TweenAnimationView extends StatefulWidget {
  final String title;

  TweenAnimationView({Key key, this.title}) : super(key: key);

  @override
  _TweenAnimationViewState createState() => _TweenAnimationViewState();
}

class _TweenAnimationViewState extends State<TweenAnimationView>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  Animation<num> animation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);

    /// 传入的begin与end必须是相同的类型 看源码里面的泛型T, 要么显示声明类型 要么隐式声明传入的数据类型相同 Tween<double>
    animation = Tween(begin: 0.0, end: 300.0).animate(controller)
      ..addListener(() {
        setState(() {
          print(animation.value);
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          print("结束了");
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          print("消失了");
          controller.forward();
        }
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          child: FlutterLogo(),
          margin: EdgeInsets.symmetric(vertical: 10),
          height: animation.value,
          width: animation.value,
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class CurvedAnimationView extends StatefulWidget {
  @override
  _CurvedAnimationViewState createState() => _CurvedAnimationViewState();
}

class _CurvedAnimationViewState extends State<CurvedAnimationView>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  Animation<num> animation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);

    animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn)
      ..addListener(() {
        setState(() {
          print(animation.value);
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          print("结束了");
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          print("消失了");
          controller.forward();
        }
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedLogo(
      animation: animation,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class AnimatedLogo extends AnimatedWidget {
  static final _opacityTween = Tween<double>(begin: 0.1, end: 1.0);
  static final _sizeTween = Tween<double>(begin: 0.0, end: 300);

  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable;
    return Scaffold(
      appBar: AppBar(
        title: Text("曲线动画"),
      ),
      body: Center(
        child: Opacity(
          opacity: _opacityTween.evaluate(animation),
          child: Container(
            child: FlutterLogo(),
            margin: EdgeInsets.symmetric(vertical: 10),
            /// 一个类的静态变量不需要写类名也可以直接在实例方法中使用
            height: AnimatedLogo._sizeTween.evaluate(animation),
            width: _sizeTween.evaluate(animation),
          ),
        ),
      ),
    );
  }
}
