import 'package:flutter/material.dart';

import 'package:play_android/HttpUtils/Request.dart';
import 'package:play_android/Account/AccountManager.dart';
import 'package:play_android/EventBus/EventBus.dart';

import 'package:play_android/Home/HomeView.dart';
import 'package:play_android/Information/InformationType.dart';
import 'package:play_android/Information/InformationFlowTopicView.dart';
import 'package:play_android/My/MyView.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;

  final _views = [
    HomeView(),
    InformationFlowTopicView(
      type: InformationType.project,
    ),
    InformationFlowTopicView(
      type: InformationType.publicNumber,
    ),
    MyView()
  ];

  var _body;

  @override
  void initState() {
    super.initState();
    autoLogin();
  }

  @override
  Widget build(BuildContext context) {
    // 通过这个方案保证tabbar的四个页面都保持存活状态,避免反复刷新
    _body = IndexedStack(
      children: _views,
      index: _selectedIndex,
    );

    return Scaffold(
      body: _body,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("首页")),
          BottomNavigationBarItem(
              icon: Icon(Icons.perm_contact_calendar), title: Text("项目")),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet), title: Text("公众号")),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("我的")),
        ],
        currentIndex: _selectedIndex, //默认选中的 index
        fixedColor: Theme.of(context).primaryColor, //选中时颜色变为黑色
        type: BottomNavigationBarType.fixed, //类型为 fixed
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; //刷新界面
    });
  }

  void autoLogin() async {
    var username = await AccountManager.getInstance().getLastLoginUserName();
    var password = await AccountManager.getInstance().getLastLoginPassword();
    if (username.isNotEmpty && password.isNotEmpty) {
      var model = await Request.login(username: username, password: password);
      if (model.errorCode == 0) {
        eventBus.fire(LoginEvent());
        AccountManager.getInstance()
            .save(info: model.data, isLogin: true, password: password);
      }
    }
  }
}
