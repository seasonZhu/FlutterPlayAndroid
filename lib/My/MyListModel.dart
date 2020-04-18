import 'package:flutter/material.dart';

import 'TargetType.dart';

class MyListModel {
  final String title;
  final IconData icon;
  final TargetType type;

  MyListModel({this.title, @required this.icon, this.type});

  static final List<MyListModel> dataSource = [
    MyListModel(
        title: "tableHeaderView", icon: Icons.close, type: TargetType.myDetail),
    MyListModel(title: "我的积分", icon: Icons.message, type: TargetType.myCoin),
    MyListModel(title: "我的收藏", icon: Icons.map, type: TargetType.myCollect),
    MyListModel(
        title: "主题设置", icon: Icons.settings, type: TargetType.themeSetting),
    MyListModel(
        title: "关于App与作者", icon: Icons.info, type: TargetType.aboutAppAndMe),
    MyListModel(title: "退出登录", icon: Icons.backspace, type: TargetType.logout),
  ];
}