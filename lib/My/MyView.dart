import 'package:flutter/material.dart';

import 'package:play_android/HttpUtils/Request.dart';
import 'package:play_android/Responses/CoinResponse.dart';
import 'package:play_android/Responses/LogoutResponse.dart';
import 'package:play_android/EventBus/EventBus.dart';
import 'package:play_android/View/Routes.dart';
import 'package:play_android/Account/LoginView.dart';
import 'package:play_android/Account/AccountManager.dart';
import 'package:play_android/Compose/ToastView.dart';
import 'MyListModel.dart';
import 'TargetType.dart';
import 'MyViewCell.dart';

class MyView extends StatefulWidget {
  @override
  _MyViewState createState() => _MyViewState();
}

class _MyViewState extends State<MyView> {
  String _icon;
  String _nickname;
  String _level = "0";
  String _rank = "0";
  String _coinCount = "0";

  @override
  void initState() {
    super.initState();
    eventBus.on<LoginEvent>().listen((event) {
      setState(() {
        _nickname = AccountManager.getInstance().info.nickname;
        _icon = AccountManager.getInstance().info.icon.isNotEmpty
            ? AccountManager.getInstance().info.icon
            : "";
      });
      _getUserCoinInfo();
    });

    eventBus.on<LogoutEvent>().listen((event) {
      setState(() {
        _nickname = null;
        _icon = null;
        _level = "0";
        _rank = "0";
        _coinCount = "0";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.1,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.assessment,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, Routes.rankingView);
              })
        ],
      ),
      body: _tableView(),
    );
  }

  Widget _tableHeaderView(MyListModel model) {
    return GestureDetector(
      child: Container(
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color(0xffffffff),
                    width: 1.0,
                  ),
                  image: _userIcon(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                _nickname ?? "未登录",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "等级 $_level  排名 $_rank   积分 $_coinCount",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        _pushToTargetView(model: model);
      },
    );
  }

  DecorationImage _userIcon() {
    if (AccountManager.getInstance().isLogin) {
      return DecorationImage(
          image: (_icon != null && _icon.isNotEmpty)
              ? NetworkImage(_icon)
              : AssetImage("assets/images/saber.jpg"),
          fit: BoxFit.cover);
    } else {
      return DecorationImage(
          image: AssetImage("assets/images/ic_head.jpeg"), fit: BoxFit.cover);
    }
  }

  ListView _tableView() {
    return ListView.separated(
        itemBuilder: (context, index) {
          if (index == 0) {
            return _tableHeaderView(MyListModel.dataSource[index]);
          }
          return MyViewCell(
            model: MyListModel.dataSource[index],
            onTapCallback: (model) {
              _pushToTargetView(model: model);
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 1.0,
          );
        },
        itemCount: MyListModel.dataSource.length);
  }

  Future<CoinResponse> _getUserCoinInfo() async {
    var model = await Request.getUserCoinInfo();
    if (model.errorCode == 0) {
      setState(() {
        _coinCount = model.data.coinCount;
        _level = model.data.level;
        _rank = model.data.rank;
      });
    }
    return model;
  }

  Future<LogoutResponse> _logout() async {
    var model = await Request.logout();
    if (model.errorCode == 0) {
      AccountManager.getInstance().clear();
      eventBus.fire(LogoutEvent());
      ToastView.show("退出登录成功");
    } else {
      ToastView.show(model.errorMsg);
    }
    return model;
  }

  Widget _showToLoginViewDialog() {
    return AlertDialog(
      title: Text("提示"),
      content: Text("您还没有登录,是否进行登录?"),
      actions: <Widget>[
        FlatButton(
          child: Text("取消"),
          onPressed: () => Navigator.pop(context), //关闭对话框
        ),
        FlatButton(
          child: Text("确定"),
          onPressed: () {
            Navigator.pop(context);
            _presentToLoginView();
          },
        ),
      ],
    );
  }

  Widget _sureToLogoutDialog() {
    return AlertDialog(
      title: Text("提示"),
      content: Text("是否登出?"),
      actions: <Widget>[
        FlatButton(
          child: Text("取消"),
          onPressed: () => Navigator.pop(context), //关闭对话框
        ),
        FlatButton(
          child: Text("确定"),
          onPressed: () {
            Navigator.pop(context);
            _logout();
          },
        ),
      ],
    );
  }

  void _logoutAction() {
    if (!AccountManager.getInstance().isLogin) {
      showDialog(
          context: context,
          builder: (context) {
            return _showToLoginViewDialog();
          });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return _sureToLogoutDialog();
          });
    }
  }

  void _pushToTargetView({MyListModel model}) {
    if (!AccountManager.getInstance().isLogin &&
        (model.type != TargetType.aboutAppAndMe &&
            model.type != TargetType.themeSetting &&
            model.type != TargetType.logout)) {
      _presentToLoginView();
      return;
    }

    var routeName;
    switch (model.type) {
      case TargetType.myDetail:
        routeName = Routes.myDetailView;
        break;
      case TargetType.myCoin:
        routeName = Routes.myCoinView;
        break;
      case TargetType.myCollect:
        routeName = Routes.myCollectView;
        break;
      case TargetType.themeSetting:
        routeName = Routes.themeSettingView;
        break;
      case TargetType.aboutAppAndMe:
        routeName = Routes.aboutAppAndMeView;
        break;
      case TargetType.logout:
        _logoutAction();
        return;
    }
    Navigator.pushNamed(context, routeName, arguments: model);
  }

  void _presentToLoginView() {
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => LoginView(),
      ),
    );
  }
}
