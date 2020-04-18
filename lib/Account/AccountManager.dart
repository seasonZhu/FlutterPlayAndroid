import 'package:play_android/Responses/AccountInfoResponse.dart';

class AccountManager {
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

  void save({AccountInfo info, bool isLogin, String password}) {
    this.info = info;
    this.isLogin = true;
    this.password = password;
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