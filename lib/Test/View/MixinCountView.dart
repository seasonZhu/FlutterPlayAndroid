import 'package:flutter/material.dart';

class MixinCountView extends StatefulWidget {
  @override
  _MixinCountViewState createState() => _MixinCountViewState();
}

class _MixinCountViewState extends State<MixinCountView> with _CountLogicMixin {

  @override
  void initState() { 
    super.initState();
    print("我是_MixinCountViewState里面的initState");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("通过Mixin进行view与逻辑分离"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Mixin, You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    print("我是_MixinCountViewState里面的dispose");
  }
}

/*
  注意看下面这两个,一个是分类
  一个是针对某种State<T>的Mixin,两者很相似
  但是重点是mixin甚至可以接管State<T>生命周期
 */
extension Logic on _MixinCountViewState {

}

mixin _CountLogicMixin < T extends StatefulWidget> on State<T> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    print("我是mixin里面的initState");
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void dispose() {
    super.dispose();
    print("我是mixin里面的dispose");
  }

}
