import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:play_android/Compose/LoadingView.dart';

class RefreshIndicatorListView extends StatefulWidget {
  @override
  RefreshIndicatorListViewState createState() =>
      RefreshIndicatorListViewState();
}

class RefreshIndicatorListViewState extends State<RefreshIndicatorListView> {
  ScrollController scrollController = ScrollController();

  String loadMoreText = "正在加载中...";

  TextStyle loadMoreTextStyle =
      TextStyle(color: const Color(0xFF4483f6), fontSize: 14.0);

  List list = List(); //列表要展示的数据

  var hasData = true;

  var page = 0;

  @override
  void initState() {
    super.initState();
    getData();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        //已经滑到底了
        if (hasData) {
          //还有数据，加载下一页
          setState(() {
            loadMoreText = "正在加载中...";
            loadMoreTextStyle =
                TextStyle(color: const Color(0xFF4483f6), fontSize: 14.0);
          });
          page++;
          print("page=" + page.toString());
          _onLoadMore();
        } else {
          setState(() {
            loadMoreText = "没有更多数据";
            loadMoreTextStyle =
                TextStyle(color: const Color(0xFF999999), fontSize: 14.0);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("原生刷新思路", style: TextStyle(color: Colors.white)),
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0.1,
      ),
      body: list.length == 0
          ? LoadingView()
          : RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.builder(
                itemCount: list.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == list.length) {
                    return _buildProgressMoreIndicator();
                  } else {
                    return ListTile(
                      title: Text(list[index]),
                    );
                  }
                },
                controller: scrollController,
              )),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: Icon(Icons.account_box),
        onPressed: () {
          print("FloatingActionButton");
        },
        elevation: 30,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildProgressMoreIndicator() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Center(
        child: hasData
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoActivityIndicator(),
                  SizedBox(
                    width: 5,
                  ),
                  Text(loadMoreText, style: loadMoreTextStyle),
                ],
              )
            : Text(loadMoreText, style: loadMoreTextStyle),
      ),
    );
  }

  // 模拟下拉 Future<Null>和Future<Void>是有区别的
  Future<Null> _onRefresh() async {
    await Future.delayed(Duration(seconds: 2), () {
      print('refresh');
      setState(() {
        list = List.generate(20, (i) => '哈喽，我是下拉刷新的数据 $i');
      });
      hasData = true;
      page = 0;
    });
  }

  // 模拟上拉
  Future<Null> _onLoadMore() async {
    await Future.delayed(Duration(seconds: 2), () {
      print('loadMore');
      setState(() {
        var newList = List.generate(10, (i) => '哈喽，我是上拉加载的数据 $i');
        list.addAll(newList);
      });
      if (page == 2) {
        hasData = false;
      }
    });
  }

  Future getData() async {
    await Future.delayed(Duration(seconds: 2), () {
      print('newwork request');
      setState(() {
        list = List.generate(30, (i) => '哈喽，我是原始数据 $i');
      });
      hasData = true;
      page = 0;
    });
  }
}
