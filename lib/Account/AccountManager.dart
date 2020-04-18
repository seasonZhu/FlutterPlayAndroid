import 'package:play_android/Responses/AccountInfoResponse.dart';

class AccountManager {
  AccountManager._();

  var info = AccountInfo();

  var isLogin = false;

  static AccountManager _instance;

  static AccountManager getInstance() {
    if (_instance == null) {
      _instance = AccountManager._();
    }
    return _instance;
  }
}