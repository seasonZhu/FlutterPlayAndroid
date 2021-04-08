import 'package:flutter/material.dart';

/* 
  Widget的思考

  在 DemoPage 中通过 Scaffold 的 body 嵌套了 StatePage;
  给 StatePage 传递了 data 为 “init” 的字符串，然后通过 _StatePageState 的构造方法传递 data ，此时页面正常显示;
  当用户点击 floatingActionButton 时，会执行 setState 触发页面更新，并且把 _DemoPageState内 的 data 改变为 “Change By setState”；
  但是最终结果 StatePage 界面依然显示 “init”。

  为什么 StatePage 界面依然显示 “init”？
  因为虽然 StatePage 这个 Widget 的 data 发生了改变，但是 StatePage 的 createState() 方法只在第一次被加载时调用，对应创建出来的 state 被保存在 Element 中，所以 _StatePageState 中的 data 只在第一次时被传递进来。
  关键就在于 _StatePageState 创建时 data 只被赋数一次。
  如果这时候要让 StatePage 的 data 正常改变，就需要使用 widget.data 。看出来了没，如果把 State 放到 Element 的级别上来看，通过  widget.data 去更新的逻辑，是不是 Widget 看起来就很像是一个配置文件。
  所以对应前面的源码，是不是对应上了，State 保存在 Element 中，而 Widget 被不断更新到 State 里，所以 State 里用 widget.xxxx 可以获取到每次更新的状态。
  也就是在写 Flutter 时， 把 Widget 当作配置文件写就对了。
 */

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  String data = "init";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// 将data数据传递给StatePage
      body: StatePage(data),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /// 改变data数据
          setState(() {
            data = "Change By setState";
          });
        },
      ),
    );
  }
}

class StatePage extends StatefulWidget {
  final String data;

  StatePage(this.data);

  @override
  _StatePageState createState() => _StatePageState(data);
}

class _StatePageState extends State<StatePage> {
  String data;

  /// data是从StatePageState的构造方法传入
  _StatePageState(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text(data ?? "")),
    );
  }
}

/* 
  局部刷新,一般都会用到GlobalKey
 */
typedef BuildWidget = Widget Function();

class PartRefreshWidget extends StatefulWidget {
  final Key key;
  final BuildWidget child;

  // 接收一个Key
  PartRefreshWidget(this.key, this.child);

  @override
  State<StatefulWidget> createState() {
    print("createState");
    return PartRefreshWidgetState(child);
  }
}

class PartRefreshWidgetState extends State<PartRefreshWidget> {
  BuildWidget child;

  PartRefreshWidgetState(this.child);

  @override
  Widget build(BuildContext context) {
    return child.call();
  }

  void update() {
    setState(() {});
  }
}

class UsePartRefreshWidget extends StatefulWidget {
  @override
  _UsePartRefreshWidgetState createState() => _UsePartRefreshWidgetState();
}

class _UsePartRefreshWidgetState extends State<UsePartRefreshWidget> {
  //1、创建一个globalKey
  GlobalKey<PartRefreshWidgetState> globalKey = GlobalKey();
  int _counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("局部更新组件使用", style: TextStyle(color: Colors.white)),
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0.1,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            PartRefreshWidget(globalKey, () {
              //2、使用 创建一个widget
              return Text(_counter.toString());
            }),
            //另外一个widget，严重局部刷新
            Text(_counter.toString()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //3、修改数值
          _counter++;
          //4、开始刷新
          globalKey.currentState.update();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
