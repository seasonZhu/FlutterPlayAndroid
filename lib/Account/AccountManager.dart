import 'package:shared_preferences/shared_preferences.dart';
import 'package:play_android/Responses/AccountInfoResponse.dart';

class AccountManager {
  final kLastLoginUserName = "kLastLoginUserName";

  final kLastLoginPassword = "kLastLoginPassword";

  AccountManager._();

  AccountInfo info;

  var isLogin = false;

  var password = "";

  get cookieHeaderValue {
    if (info == null) {
      return "";
    }else {
      return "loginUserName=${info.nickname};loginUserPassword=$password";
    }
  }

  void save({AccountInfo info, bool isLogin, String password}) async {
    this.info = info;
    this.isLogin = true;
    this.password = password;

    var userDefine = await SharedPreferences.getInstance();
    userDefine.setString(kLastLoginUserName, info.username);
    userDefine.setString(kLastLoginPassword, password);
  }

  Future<String> getLastLoginUserName() async {
    var userDefine = await SharedPreferences.getInstance();
    return userDefine.getString(kLastLoginUserName) ?? "";
  }

  Future<String> getLastLoginPassword() async {
    var userDefine = await SharedPreferences.getInstance();
    return userDefine.getString(kLastLoginPassword) ?? "";
  }

  void clear() {
    info = null;
    isLogin = false;
    password = "";
  }

  static AccountManager _instance;

  static AccountManager getInstance() {
    if (_instance == null) {
      _instance = AccountManager._();
    }
    return _instance;
  }
}