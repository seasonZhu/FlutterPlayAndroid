import 'package:flutter/material.dart';
import 'package:play_android/Compose/LoadingView.dart';

import 'package:play_android/HttpUtils/Request.dart';
import 'package:play_android/Responses/AccountInfoResponse.dart';
import 'package:play_android/View/Routes.dart';
import 'package:play_android/Compose/Space.dart';
import 'package:play_android/Compose/ToastView.dart';
import 'package:play_android/EventBus/EventBus.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var _userNameTextFiledDelegate = TextEditingController(text: "");

  var _passwordTextFiledDelegate = TextEditingController(text: "");

  var _obscureText = true;

  var _isLoginNow = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("登录", style: TextStyle(color: Colors.white)),
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
                          obscureText: _obscureText,
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
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Space(),
                      Padding(
                        padding: EdgeInsets.only(top: 20, right: 15),
                        child: GestureDetector(
                          child: Text(
                            "还没有注册?",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 15),
                          ),
                          onTap: () {
                            _pushToRegisterView(context);
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
                          "登录",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        onPressed: () {
                          _loginAction();
                        },
                      ),
                    ),
                  ),
                  _showLoginView(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 各种push的研究
  void _pushToRegisterView(BuildContext context) {
    Navigator.pushReplacementNamed(context, Routes.registerView);
    //Navigator.pushNamed(context, Routes.registerView);
    //Navigator.pushNamedAndRemoveUntil(context, Routes.registerView, ModalRoute.withName(Routes.loginView));

    //Navigator.pop(context);
    //Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     fullscreenDialog: true,
    //     builder: (context) => RegisterView(),
    //   ),
    // );

    // Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(fullscreenDialog: true, builder: (BuildContext context) => RegisterView()),
    //   ModalRoute.withName(Routes.loginView),
    // );
  }

  Widget _showLoginView() {
    return _isLoginNow
        ? Container(
            padding: EdgeInsets.only(top: 20),
            child: LoadingView(message: "正在登录..."),
          )
        : Container();
  }

  void _loginAction() {
    if (_isLoginNow) return;

    if (_userNameTextFiledDelegate.text.trim().isEmpty ||
        _passwordTextFiledDelegate.text.trim().isEmpty) {
      ToastView.show("手机号或者密码不能为空!");
      return;
    }

    // 关闭键盘
    FocusScope.of(context).requestFocus(FocusNode());

    login();
  }

  Future<AccountInfoResponse> login() async {
    setState(() {
      _isLoginNow = true;
    });

    var model = await Request.login(
        username: _userNameTextFiledDelegate.text.trim(),
        password: _passwordTextFiledDelegate.text.trim());
    if (model.errorCode == 0) {
      Navigator.pop(context);
      eventBus.fire(LoginEvent());
      ToastView.show("登录成功！");
    } else {
      ToastView.show(model.errorMsg);
    }

    setState(() {
      _isLoginNow = false;
    });

    return model;
  }

  @override
  void dispose() {
    _userNameTextFiledDelegate.dispose();
    _passwordTextFiledDelegate.dispose();
    super.dispose();
  }
}
