import 'package:flutter/material.dart';

class TodayHotNavigatorView extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("今天头条局部导航", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.1,
      ),
      body: Center(
        child: Container(
          height: 350,
          width: 300,
          child: Navigator(
            // 这个地方只能是根标识符,使用其他的还不行
            initialRoute: '/',
            onGenerateRoute: (RouteSettings settins) {
              WidgetBuilder builder;
              switch (settins.name) {
                case '/':
                  builder = (context) => PageC();
                  break;
              }
              return MaterialPageRoute(builder: builder);
            },
          ),
        ),
      ),
    );
  }
}

class PageC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Center(
        child: Card(
          child: Column(
            children: <Widget>[
              _buildItem(Icons.clear, '不感兴趣', '减少这类内容'),
              Divider(),
              // 注意点击箭头才跳转
              _buildItem(Icons.access_alarm, '举报', '标题夸张，内容质量差 等',
                  showArrow: true, onPress: () {
                print("点击事件");
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return PageD();
                }));
              }),
              Divider(),
              _buildItem(Icons.perm_identity, '拉黑作者：新华网客户端', ''),
              Divider(),
              _buildItem(Icons.account_circle, '屏蔽', '军事视频、驾驶员等'),
            ],
          ),
        ),
      ),
    );
  }

  _buildItem(IconData iconData, String title, String content,
      {bool showArrow = false, Function onPress}) {
    return Row(
      children: <Widget>[
        Icon(iconData),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontSize: 18),
              ),
              Text(
                content,
                style: TextStyle(
                    color: Colors.black.withOpacity(.5), fontSize: 14),
              )
            ],
          ),
        ),
        !showArrow
            ? Container()
            : IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                iconSize: 16,
                onPressed: onPress,
              ),
      ],
    );
  }
}

class PageD extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 250,
      color: Colors.grey.withOpacity(.5),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Text('返回'),
              SizedBox(
                width: 30,
              ),
              Text('举报'),
            ],
          ),
        ],
      ),
    );
  }
}
