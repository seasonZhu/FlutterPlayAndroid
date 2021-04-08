import 'package:flutter/material.dart';

import 'package:play_android/Compose/PAWebView.dart';
import 'package:play_android/Test/View/AnimationFlutterLogo.dart';

class AboutAppAndMeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("关于App与作者", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.1,
      ),
      body: _buildSingleChildScrollView(context),
    );
  }

  Widget _buildSingleChildScrollView(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: AnimationFlutterLogo(
              size: 100,
            ),
          ),
          Divider(),
          ListTile(
            leading: Text("玩安卓App Flutter版本"),
            trailing: Text("作者:seasonZhu"),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Text("特别感谢: 历时三天，完成了Flutter版本的玩安卓"),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              _pushToWebView(
                  context: context,
                  title: "历时三天，完成了Flutter版本的玩安卓",
                  link: "https://juejin.im/post/5e901fff51882573bd5f3f88");
            },
          ),
          Divider(),
          ListTile(
            leading: Text("我的简书"),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              _pushToWebView(
                  context: context,
                  title: "我的简书",
                  link: "https://www.jianshu.com/u/a426bd8bbca5");
            },
          ),
          Divider(),
          ListTile(
            leading: Text("我的GitHub"),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              _pushToWebView(
                  context: context,
                  title: "我的GitHub",
                  link: "https://github.com/seasonZhu");
            },
          ),
          Divider(),
          ListTile(
            leading: Text("打赏我"),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Center(child: Text("打赏")),
                    content: Image(
                      image: AssetImage("assets/images/season_ali_pay.jpg"),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  void _pushToWebView({BuildContext context, String title, String link}) {
    print("点击了");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PAWebView(
          title: title,
          link: link,
        ),
      ),
    );
  }
}
