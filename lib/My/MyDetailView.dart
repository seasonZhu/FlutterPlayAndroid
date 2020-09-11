import 'dart:io';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:play_android/Account/AccountManager.dart';
import 'package:play_android/Compose/ShakeView.dart';

class MyDetailView extends StatefulWidget {
  @override
  _MyDetailViewState createState() => _MyDetailViewState();
}

class _MyDetailViewState extends State<MyDetailView> {
  var _userInfo = AccountManager.getInstance().info;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的资料", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.1,
      ),
      body: _buildSingleChildScrollView(),
    );
  }

  File _image;

  /// 头像更新
  Future<void> _portraitUpdate() async {
    /// 这个方法过期了 但是新方法await ImagePicker().getImage(source: ImageSource.camera); 拿到的Future包裹的东西不知道如何使用
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  /// 我个人认为这个地方的cell布局写的不够好
  Widget _buildSingleChildScrollView() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              _portraitUpdate();
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20.0),
              padding:
                  const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '头像',
                    style: TextStyle(fontSize: 16),
                  ),
                  ShakeView(
                    child: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2.0,
                        ),
                        image: DecorationImage(
                          image: _image == null
                              ? AssetImage("assets/images/saber.jpg")
                              : FileImage(_image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {
              print("点击了昵称行");
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20.0),
              padding:
                  const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '昵称',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    _userInfo.nickname,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          Container(
            margin: const EdgeInsets.only(left: 20.0),
            padding:
                const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '电子邮箱',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  _userInfo.email.isNotEmpty ? _userInfo.email : "暂未设置",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {
              print("密码行");
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20.0),
              padding:
                  const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '密码',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "*" * AccountManager.getInstance().info.password.length,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {
              print("公开名称行");
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20.0),
              padding:
                  const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      '公开名称',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      // 'Android,C/C++,J2ME/K-Java,Python,.NET/C#',
                      _userInfo.publicName,
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {
              print("类型行");
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20.0),
              padding:
                  const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      '类型',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      // '手机软件开发，服务器开发，软件开发管理',
                      _userInfo.type.toString(),
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          Container(
            margin: const EdgeInsets.only(left: 20.0),
            padding:
                const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '用户名称',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  _userInfo.username,
                  style: TextStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
