import 'dart:io';
import 'package:flutter/material.dart';

import 'package:device_info/device_info.dart';
import 'package:drag_container/drag/drag_container.dart';
import 'package:drag_container/drag_container.dart';

class BottomDragView extends StatefulWidget {
  @override
  _BottomDragViewState createState() => _BottomDragViewState();
}

class _BottomDragViewState extends State<BottomDragView> {
  ///滑动控制器
  ScrollController scrollController = ScrollController();

  ///抽屉控制器
  DragController dragController = DragController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("抽屉效果", style: TextStyle(color: Colors.white)),
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0.1,
      ),
      backgroundColor: Colors.grey,

      ///页面主体使用层叠布局
      body: Stack(
        children: <Widget>[
          Center(
            child: getMyPatformView(), //Text("哈哈哈"),
          ),

          ///抽屉视图
          buildDragWidget(),
        ],
      ),
    );
  }

  Widget buildDragWidget() {
    ///层叠布局中的底部对齐
    return Align(
      alignment: Alignment.bottomCenter,
      child: DragContainer(
        ///抽屉关闭时的高度 默认0.4
        initChildRate: 0.1,

        ///抽屉打开时的高度 默认0.4
        maxChildRate: 0.618,

        ///是否显示默认的标题
        isShowHeader: true,

        ///背景颜色
        backGroundColor: Colors.white,

        ///背景圆角大小
        cornerRadius: 12,

        ///自动上滑动或者是下滑的分界值
        maxOffsetDistance: 1.5,

        ///抽屉控制器
        controller: dragController,

        ///滑动控制器
        scrollController: scrollController,

        ///自动滑动的时间
        duration: Duration(milliseconds: 800),

        ///抽屉的子Widget
        dragWidget: buildListView(),

        ///抽屉标题点击事件回调
        dragCallBack: (isOpen) {
          print("是否打开 $isOpen");
        },
      ),
    );
  }

  buildListView() {
    return ListView.builder(
      ///列表的控制器 与抽屉视图关联
      controller: scrollController,

      ///需要注意的是这里的控制器需要使用
      ///builder函数中回调中的 控制器
      itemCount: 20,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
            onTap: () {
              print("点击事件 $index");

              ///关闭抽屉
              dragController.close();
            },
            child: ListTile(title: Text('测试数据 $index')));
      },
    );
  }

  Widget getMyPatformView() {
    if (Platform.isAndroid) {
      return Container(
        child: Center(
          child: Text('Android is not yet supported by this plugin'),
        ),
      );
    } else if (Platform.isIOS) {
      return UiKitView(
        viewType: 'TestViewObject',
      );
    }

    return Text('Not yet supported by this plugin');
  }

  void getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      print('IOS设备：');
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print(iosInfo);
    } else if (Platform.isAndroid) {
      print('Android设备');
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print(androidInfo);
    }
  }
}
