import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:play_android/View/Routes.dart';

/* 专用的测试界面入口View */
class TestView extends StatefulWidget {
  @override
  _TestViewState createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  final titiles = [
    {"头条客户端举报场景": Routes.todayHotNavigatorView},
    {"通过Mixin进行view与逻辑分离": Routes.mixinCountView},
    {"新组件NanigationRail": Routes.nanigationRailView},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("测试界面入口", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.1,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () { _showCupertinoInputAlert(); })
        ],
      ),
      body: ListView.separated(
          itemBuilder: (cxt, index) {
            return ListTile(
              title: Text(titiles[index].keys.first),
              onTap: () {
                Navigator.of(context).pushNamed(titiles[index].values.first);
              },
            );
          },
          separatorBuilder: (context, index) {
            // 注意height和thickness联合起来使用才能体现其意义,单独使用thickness也是可以的,但是单独把height设置很大也是没有意义的
            return Divider();
          },
          itemCount: titiles.length),
    );
  }

  /// 一个显示iOS风格的输入框,仅仅是简单实现,
  void _showCupertinoInputAlert() {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('提示'),
            content: Column(
              children: <Widget>[
                CupertinoTextField(),
                Divider(),
                CupertinoTextField(),
              ],
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('取消'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CupertinoDialogAction(
                child: Text('确认'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
