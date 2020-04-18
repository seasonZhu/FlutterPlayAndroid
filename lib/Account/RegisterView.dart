import 'package:flutter/material.dart';

import 'package:play_android/HttpUtils/Request.dart';
import 'package:play_android/Responses/AccountInfoResponse.dart';
import 'package:play_android/EventBus/EventBus.dart';
import 'package:play_android/Compose/ToastView.dart';
import 'package:play_android/Compose/LoadingView.dart';
import 'AccountManager.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  var _userNameTextFiledDelegate = TextEditingController(text: "");

  var _passwordTextFiledDelegate = TextEditingController(text: "");

  var _checkPasswordTextFiledDelegate = TextEditingController(text: "");

  var _passwordObscureText = true;

  var _checkPasswordObscureText = true;

  var _isRegisterNow = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              _popToRoot(context);
            },
          ),
          title: Text("注册", style: TextStyle(color: Colors.white)),
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0.1,
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: _userNameTextFiledDelegate,
                          decoration: InputDecoration(
                              hintText: '手机号',
                              labelText: '用户名',
                              prefixIcon: Icon(Icons.person)),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: InkWell(
                          child: Icon(Icons.clear),
                          onTap: () {
                            print("clear");
                            _userNameTextFiledDelegate.text = "";
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: _passwordTextFiledDelegate,
                          decoration: InputDecoration(
                              hintText: '密码',
                              labelText: '密码',
                              prefixIcon: Icon(Icons.lock)),
                          obscureText: _passwordObscureText,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        width: 38,
                        child: InkWell(
                          child: Image.asset(
                            "assets/images/ic_eye.png",
                            width: 20,
                            height: 20,
                          ),
                          onTap: () {
                            setState(() {
                              _passwordObscureText = !_passwordObscureText;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: _checkPasswordTextFiledDelegate,
                          decoration: InputDecoration(
                              hintText: '确认密码',
                              labelText: '确认密码',
                              prefixIcon: Icon(Icons.lock)),
                          obscureText: _checkPasswordObscureText,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        width: 38,
                        child: InkWell(
                          child: Image.asset(
                            "assets/images/ic_eye.png",
                            width: 20,
                            height: 20,
                          ),
                          onTap: () {
                            setState(() {
                              _checkPasswordObscureText =
                                  !_checkPasswordObscureText;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                    child: Container(
                      width: 400,
                      height: 44,
                      child: FlatButton(
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          "注册并登录",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        onPressed: () {
                          _registerAction();
                        },
                      ),
                    ),
                  ),
                  _showRegisterView(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 各种pop研究
  void _popToRoot(BuildContext context) {
    Navigator.pop(context);
    //Navigator.popUntil(context, ModalRoute.withName(Routes.root));
    //Navigator.pop(context);
    //Navigator.popAndPushNamed(context, "/");
  }

  Widget _showRegisterView() {
    return _isRegisterNow
        ? Container(
            padding: EdgeInsets.only(top: 20),
            child: LoadingView(message: "正在注册..."),
          )
        : Container();
  }

  void _registerAction() {
    // 登录与注册有关的账号与密码的正则没有做,这里只是展示了基本逻辑

    if (_isRegisterNow) return;

    if (_userNameTextFiledDelegate.text.trim().isEmpty ||
        _passwordTextFiledDelegate.text.trim().isEmpty ||
        _checkPasswordTextFiledDelegate.text.trim().isEmpty) {
      ToastView.show("手机号或者密码不能为空!");
      return;
    }

    if (_passwordTextFiledDelegate.text.trim().isEmpty != _checkPasswordTextFiledDelegate.text.trim().isEmpty) {
      ToastView.show("两次密码输入不一致!");
      return;
    }

    // 关闭键盘
    FocusScope.of(context).requestFocus(FocusNode());

    register();
  }

  Future<AccountInfoResponse> register() async {
    setState(() {
      _isRegisterNow = true;
    });

    var model = await Request.register(
        username: _userNameTextFiledDelegate.text.trim(),
        password: _passwordTextFiledDelegate.text.trim(),
        rePassword: _checkPasswordTextFiledDelegate.text.trim());
    if (model.errorCode == 0) {
      ToastView.show("注册成功,即将进行登录");
      login();
    } else {
      ToastView.show(model.errorMsg);
    }

    setState(() {
      _isRegisterNow = false;
    });

    return model;
  }

  Future<AccountInfoResponse> login() async {
    var model = await Request.login(
        username: _userNameTextFiledDelegate.text.trim(),
        password: _passwordTextFiledDelegate.text.trim());
    if (model.errorCode == 0) {
      Navigator.pop(context);
      eventBus.fire(LoginEvent());
      AccountManager.getInstance().save(
          info: model.data,
          isLogin: true,
          password: _passwordTextFiledDelegate.text.trim());
      ToastView.show("登录成功！");
    } else {
      ToastView.show(model.errorMsg);
    }

    return model;
  }

  void dispose() {
    _userNameTextFiledDelegate.dispose();
    _passwordTextFiledDelegate.dispose();
    _checkPasswordTextFiledDelegate.dispose();
    super.dispose();
  }
}
