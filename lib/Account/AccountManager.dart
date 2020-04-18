import 'package:play_android/Responses/AccountInfoResponse.dart';

class AccountManager {
  AccountManager._();

  var info;

  var isLogin = false;

  var password = "";

  get cookieHeaderValue {
    if (info == null) {
      return "";
    }else {
      return "loginUserName=${info.nickname};loginUserPassword=$password";
    }
  }

  static AccountManager _instance;

  static AccountManager getInstance() {
    if (_instance == null) {
      _instance = AccountManager._();
    }
    return _instance;
  }
}