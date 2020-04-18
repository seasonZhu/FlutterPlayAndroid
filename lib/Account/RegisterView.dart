import 'package:flutter/material.dart';

import 'package:play_android/View/Routes.dart';

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
                          child: Image.asset("assets/images/ic_eye.png", width: 20, height: 20,),
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
                          child: Image.asset("assets/images/ic_eye.png", width: 20, height: 20,),
                          onTap: () {
                            setState(() {
                              _checkPasswordObscureText = !_checkPasswordObscureText;
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
                        onPressed: () {},
                      ),
                    ),
                  ),
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
}

