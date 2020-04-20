import 'package:flutter/material.dart';

class BottomFunctionModel {
  final String title;
  final IconData iconData;
  final BottomFunctionType type;

  BottomFunctionModel({this.title, this.iconData, this.type});
}

enum BottomFunctionType {
  collect,
  unCollect,
  copyLink,
  openByBrowser,
  weChatShare,
  refresh
}
