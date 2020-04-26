import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:play_android/Responses/AccountInfoResponse.dart';

class AccountManager {
  final kLastLoginUserName = "kLastLoginUserName";

  final kLastLoginPassword = "kLastLoginPassword";

  final kLastThemeSettingIndex = "kLastThemeSettingIndex";

  final kAccountInfo = "kAccountInfo";

  AccountInfo info;

  var isLogin = false;

  // 只读计算属性
  String get cookieHeaderValue {
    if (info == null) {
      return "";
    }else {
      return "loginUserName=${info.username};loginUserPassword=${info.password}";
    }
  }

  void save({AccountInfo info, bool isLogin, String password}) async {
    this.info = info;
    this.isLogin = true;
    this.info.password = password;

    var userDefine = await SharedPreferences.getInstance();
    userDefine.setString(kLastLoginUserName, info.username);
    userDefine.setString(kLastLoginPassword, password);
    // 本来想尝试保存一个字典的,结果没这个方法,只有List<String>,但是我可以将Map转为String在存呀
    var infoJsonString = json.encode(info.toJson());
    userDefine.setString(kAccountInfo, infoJsonString);
  }

  Future<bool> saveLastThemeSettingIndex(int index) async {
    var userDefine = await SharedPreferences.getInstance();
    return userDefine.setInt(kLastThemeSettingIndex, index);
  }

  Future<String> getLastLoginUserName() async {
    var userDefine = await SharedPreferences.getInstance();
    return userDefine.getString(kLastLoginUserName) ?? "";
  }

  Future<String> getLastAccountInfo() async {
    var userDefine = await SharedPreferences.getInstance();
    return userDefine.getString(kAccountInfo) ?? "";
  }

  Future<int> getLastThemeSettingIndex() async {
    var userDefine = await SharedPreferences.getInstance();
    return userDefine.getInt(kLastThemeSettingIndex) ?? 0;
  }

  Future<String> getLastLoginPassword() async {
    var userDefine = await SharedPreferences.getInstance();
    return userDefine.getString(kLastLoginPassword) ?? "";
  }

  void clear() {
    info = null;
    isLogin = false;
  }

  // 单例模式写法

  AccountManager._();

  static AccountManager _instance;

  static AccountManager getInstance() {
    if (_instance == null) {
      _instance = AccountManager._();
    }
    return _instance;
  }
}