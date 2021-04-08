import 'package:flutter/material.dart';

import 'package:play_android/Compose/PAWebView.dart';
import 'package:play_android/Test/View/AnimationFlutterLogo.dart';

class AboutAppAndMeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("关于App与作者"),
        elevation: 0.1,
      ),
      body: _listView(context),
    );
  }

  Widget _listView(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: AnimationFlutterLogo(
            size: 100,
          ),
        ),
        Divider(
          height: 1,
        ),
        ListTile(
          leading: Text("玩安卓App Flutter版本"),
          trailing: Text("作者:seasonZhu"),
          onTap: () {},
        ),
        Divider(
          height: 1,
        ),
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
        Divider(
          height: 1,
        ),
        ListTile(
          leading: Text("我的掘金"),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            _pushToWebView(
                context: context,
                title: "我的掘金",
                link: "https://juejin.cn/user/4353721778057997");
          },
        ),
        Divider(
          height: 1,
        ),
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
        Divider(
          height: 1,
        ),
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
        Divider(
          height: 1,
        ),
      ],
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
