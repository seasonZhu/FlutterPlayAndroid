import 'package:flutter/material.dart';

import 'package:play_android/Test/View/DataLine.dart';

/// 这个页面的销毁还有问题
class DataLineView extends StatefulWidget {
  @override
  _DataLineViewState createState() => _DataLineViewState();
}

class _DataLineViewState extends State<DataLineView> with MultDataLine {
  var key = 0;

  final textKey = "textKey";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("DataLineView"),
        ),
        body: ListView(children: [
          GestureDetector(
            child: Container(
              width: 150,
              height: 60,
              child: Center(
                  child: Text(
                'key1的触发者',
                style: TextStyle(color: Colors.white, fontSize: 20),
              )),
              decoration: BoxDecoration(color: Colors.grey),
            ),
            onTap: () {
              //发送一个数据
              getLine(textKey).setData(key++);
            },
          ),
          //绑定监听对象
          getLine(textKey).addObserver((context, data) {
            //实际的观察者
            return Text(
              'key1当前的数据为 $data',
              style: TextStyle(
                  fontSize: 19,
                  color: Colors.green,
                  fontWeight: FontWeight.w600),
            );
          }),
          getLine(textKey).addObserver(
            (context, data) {
              return Text(
                'key1当前的数据为 $data',
                style: TextStyle(
                    fontSize: 19,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600),
              );
            },
          ),
        ]));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
