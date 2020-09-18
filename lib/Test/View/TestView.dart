import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:r_upgrade/r_upgrade.dart';
import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'package:play_android/View/Routes.dart';


/* 专用的测试界面入口View */
class TestView extends StatefulWidget {
  @override
  _TestViewState createState() => _TestViewState();
}

class _TestViewState extends State<TestView> with RouteAware {
  final titiles = [
    {"头条客户端举报场景": Routes.todayHotNavigatorView},
    {"通过Mixin进行view与逻辑分离": Routes.mixinCountView},
    {"新组件NanigationRail": Routes.nanigationRailView},
    {"DismissibelView的使用": Routes.dismissibleView},
    {"倒圆角的几种方式": Routes.roundView},
    {"使用StreamBuilder重构排行榜页面": Routes.rankingStreamView},
    {"使用BLoC重构排行榜页面": Routes.rankingBlocView},
    {"计算器布局思路": Routes.calculatorView},
    {"BlocExampleApp": Routes.blocExampleApp},
    {"底部抽屉效果": Routes.bottomDragView},
    {"tiledLines": Routes.tiledLines},
    {"获取空间位置进行弹窗": Routes.pressLocationView},
    {"DataLine的刷新思路": Routes.dataLineView},
    {"五角星":Routes.startClip}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("测试界面入口", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.1,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                _showCupertinoInputAlert();
                //_saveImage();
                //_appUpdate();
              })
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

  // 保存图片
  void saveImage() async {
    final String url =
        "https://ss0.baidu.com/94o3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=a62e824376d98d1069d40a31113eb807/838ba61ea8d3fd1fc9c7b6853a4e251f94ca5f46.jpg";
    var response = await Dio()
        .get(url, options: Options(responseType: ResponseType.bytes));
    final result =
        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print('result:$result');
  }

  void appUpdate() async {
    bool isSuccess = await RUpgrade.upgradeFromAppStore(
      '1358989531', //例如:微信的AppId:414478124
    );
    print(isSuccess);

    String versionName = await RUpgrade.getVersionFromAppStore(
      '414478124', //例如:微信的AppId:414478124
    );
    print(versionName);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    super.dispose();
    routeObserver.unsubscribe(this);
  }

  @override
  void didPush() {
    final route = ModalRoute.of(context).settings.name;
    print('A-didPush route: $route');
  }

  @override
  void didPopNext() {
    final route = ModalRoute.of(context).settings.name;
    print('A-didPopNext route: $route');
  }

  @override
  void didPushNext() {
    final route = ModalRoute.of(context).settings.name;
    print('A-didPushNext route: $route');
  }

  @override
  void didPop() {
    final route = ModalRoute.of(context).settings.name;
    print('A-didPop route: $route');
  }
}
