import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
/*
// void main() {
//   BlocSupervisor.delegate = SimpleBlocDelegate();
//   runApp(BlocExampleApp());
// }

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}

class BlocExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeData>(
        builder: (_, theme) {
          return MaterialApp(
            title: 'Flutter Demo',
            home: BlocProvider(
              create: (_) => CounterBloc(),
              child: CounterPage(),
            ),
            theme: theme,
          );
        },
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  OverlayEntry overlayEntry;

  final hudButtonKey = GlobalKey(debugLabel: "hudButtonKey");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.1,
      ),
      body: BlocBuilder<CounterBloc, int>(
        builder: (_, count) {
          return Center(
            child: Text(
              '$count',
              style: const TextStyle(fontSize: 24.0),
            ),
          );
        },
      ),

      /// 这里报了一个错: There are multiple heroes that share the same tag within a subtree,
      /// 因为我的漂浮button其实一个FloatingActionButton的列表,但是创建FloatingActionButton使用的默认的heroTag,于是报错了
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              heroTag: "add",
              child: const Icon(Icons.add),
              onPressed: () =>
                  context.bloc<CounterBloc>().add(CounterEvent.increment),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              heroTag: "decrement",
              child: const Icon(Icons.remove),
              onPressed: () =>
                  context.bloc<CounterBloc>().add(CounterEvent.decrement),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              heroTag: "themeEvent",
              child: const Icon(Icons.brightness_6),
              onPressed: () => context.bloc<ThemeBloc>().add(ThemeEvent.toggle),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              heroTag: "error",
              backgroundColor: Colors.red,
              child: const Icon(Icons.error),
              onPressed: () =>
                  context.bloc<CounterBloc>().add(CounterEvent.error),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              key: hudButtonKey,
              heroTag: "hud",
              backgroundColor: Colors.amber,
              child: const Icon(Icons.settings_input_hdmi),
              onPressed: () => hudTrackAction(context),
            ),
          ),
        ],
      ),
    );
  }

  void hudAction(BuildContext context) {
    /// 1. 创建一个 overlayEntry 实例，builder 方法返回一个 Widget
    /// 该 Widget 会被渲染到页面顶层
    overlayEntry = OverlayEntry(
      builder: (context) => Container(
        color: Colors.black.withOpacity(.4),
        child: Center(
          child: RaisedButton(
            onPressed: () {
              /// 3. 执行 remove 方法销毁 overlayEntry 实例
              overlayEntry.remove();
            },
            child: Text('点我关闭 OverlayEntry'),
          ),
        ),
      ),
    );

    /// 2. 使用 OverlayState.insert 方法来显示 overlayEntry
    Overlay.of(context).insert(overlayEntry);
  }

  /// 添加蒙层的方法
  void hudTrackAction(BuildContext context) {
    /// 3. 通过下面的代码来获取组件的尺寸和位置
    RenderBox renderBox = hudButtonKey.currentContext.findRenderObject();
    Size size = renderBox.size;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    print(size);
    print(offset);

    overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          /// 我们使用了 ColorFiltered 来实现这个功能
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              /// 遮罩层颜色
              Colors.black.withOpacity(.4),
              BlendMode.srcOut,
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    /// 任何颜色均可
                    color: Colors.white,
                    backgroundBlendMode: BlendMode.dstOut,
                  ),
                ),
                Positioned(
                  /// 和需要高亮组件的大小和位置均一致
                  child: Container(
                    /// 任何颜色均可
                    color: Colors.white,
                    width: size.width,
                    height: size.height,
                  ),
                  left: offset.dx,
                  top: offset.dy,
                ),
                Positioned(
                  /// 和需要高亮组件的大小和位置均一致
                  child: Container(
                    width: 200,
                    //height: 44,
                    child: FlatButton(
                      onPressed: () {
                        /// 3. 执行 remove 方法销毁 overlayEntry 实例
                        overlayEntry.remove();
                      },
                      child: Text(
                        '这是一个测试按钮, 点击取消蒙板',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  left: offset.dx - size.width - 100,
                  top: offset.dy - size.height - 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(overlayEntry);
  }
}

enum CounterEvent { increment, decrement, error }

class CounterBloc extends Bloc<CounterEvent, int> {
  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.decrement:
        yield state - 1;
        break;
      case CounterEvent.increment:
        yield state + 1;
        break;
      case CounterEvent.error:
        yield state;
        break;
      default:
        throw Exception('oops');
    }
  }
}

enum ThemeEvent { toggle }

class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
  @override
  ThemeData get initialState => ThemeData.light();

  @override
  Stream<ThemeData> mapEventToState(ThemeEvent event) async* {
    switch (event) {
      case ThemeEvent.toggle:
        yield state == ThemeData.dark() ? ThemeData.light() : ThemeData.dark();
        break;
    }
  }
}
*/