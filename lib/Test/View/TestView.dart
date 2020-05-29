import 'package:flutter/material.dart';

/* 专用的测试界面入口View */
class TestView extends StatefulWidget {
  @override
  _TestViewState createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  final titiles = [
    {"头条客户端举报场景": "/todayHotNavigatorView"},
    {"通过Mixin进行view与逻辑分离": "/mixinCountView"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("测试界面入口", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.1,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {})
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
          return Divider(
            height: 1.0,
          );
        },
          itemCount: titiles.length),
    );
  }
}