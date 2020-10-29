import 'package:flutter/material.dart';

class PressLocationView extends StatelessWidget {
  Widget button(context, index) {
    buttonKey = GlobalKey(debugLabel: "$index");
    return Align(
      key: buttonKey,
      alignment: Alignment.centerRight,
      child: IconButton(
        icon: Icon(Icons.more_horiz, color: Colors.black),
        onPressed: () {
          // 问题关键,我无法获得cell的相对坐标位置
          RenderBox renderBox = buttonKey.currentContext.findRenderObject();
          // 找到并渲染对象overlay
          RenderBox overlay =
              Overlay.of(buttonKey.currentContext).context.findRenderObject();
          // 位置设置
          RelativeRect position = RelativeRect.fromRect(
            Rect.fromPoints(
              renderBox.localToGlobal(Offset.zero, ancestor: overlay),
              renderBox.localToGlobal(Offset.zero, ancestor: overlay),
            ),
            Offset.zero & overlay.size,
          );
          print(position);

          // 使用路由跳转方式
          Navigator.push(
            context,
            PopRoute(
              child: Popup(
                btnContext: context,
                rect: position,
                onClick: (string) => debugPrint('你点击了$string'), // 传到外面来的回调事件
              ),
            ),
          );
        },
      ),
    );
  }

  final GlobalKey someKey = GlobalKey();

  GlobalKey buttonKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("点击位置", style: TextStyle(color: Colors.white)),
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0.1,
      ),
      body: tapView(context), //ListView.builder(itemBuilder: button), //
    );
  }

  Widget tapView(BuildContext context) {
    return GestureDetector(
        onTap: () {
          RenderBox renderBox = someKey.currentContext.findRenderObject();
          // 找到并渲染对象overlay
          RenderBox overlay =
              Overlay.of(someKey.currentContext).context.findRenderObject();
          // 位置设置
          RelativeRect position = RelativeRect.fromRect(
            Rect.fromPoints(
              renderBox.localToGlobal(Offset.zero, ancestor: overlay),
              renderBox.localToGlobal(Offset.zero, ancestor: overlay),
            ),
            Offset.zero & overlay.size,
          );
          print(position);

          // 使用路由跳转方式
          Navigator.push(
            context,
            PopRoute(
              child: Popup(
                btnContext: context,
                rect: position,
                onClick: (string) => debugPrint('你点击了$string'), // 传到外面来的回调事件
              ),
            ),
          );
        },
        child: Center(
          child: Text("点击弹出悬浮窗", style: TextStyle(fontSize: 20), key: someKey),
        ));
  }
}

class PopRoute extends PopupRoute {
  // push的耗时，milliseconds为毫秒
  final Duration _duration = Duration(milliseconds: 300);

  // 接收一个child，也就是我们push的内容。
  Widget child;

  // 构造方法
  PopRoute({@required this.child});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}

// 类型声明回调
typedef OnItem = Function(String value);

class Popup extends StatefulWidget {
  final BuildContext btnContext;
  final OnItem onClick; //点击child事件
  final RelativeRect rect;

  Popup({this.btnContext, this.onClick, this.rect});

  PopupState createState() => PopupState();
}

class PopupState extends State<Popup> {
  // 声明对象
  RenderBox button;
  RenderBox overlay;
  RelativeRect position;

  @override
  void initState() {
    super.initState();
    // 找到并渲染对象button
    // button = widget.btnContext.findRenderObject();
    // // 找到并渲染对象overlay
    // overlay = Overlay.of(widget.btnContext).context.findRenderObject();
    // // 位置设置
    // position = RelativeRect.fromRect(
    //   Rect.fromPoints(
    //     button.localToGlobal(Offset.zero, ancestor: overlay),
    //     button.localToGlobal(Offset.zero, ancestor: overlay),
    //   ),
    //   Offset.zero & overlay.size,
    // );
  }

  // item构建
  Widget itemBuild(item) {
    // 字体样式
    TextStyle labelStyle = TextStyle(color: Colors.white);

    return Expanded(
      child: FlatButton(
        //点击Item
        onPressed: () {
          // 如果没接收也返回的花就会报错，所以这里需要判断
          if (widget.onClick != null) {
            Navigator.of(context).pop();
            widget.onClick(item); // 事件返回String类型的值
          }
        },
        child: Text(item, style: labelStyle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: <Widget>[
          Container(
            // 设置一个容器组件，是整屏幕的。
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Color.fromRGBO(75, 75, 75, 0.5), // 它的颜色为透明色
          ),
          Positioned(
            child: Container(
              width: 200,
              height: 44,
              decoration: BoxDecoration(
                color: Color.fromRGBO(75, 75, 75, 1.0),
                borderRadius: BorderRadius.all(Radius.circular(4.0)), // 圆角
              ),
              child: Row(children: ['点赞', '评论'].map(itemBuild).toList()),
            ),
            top: widget.rect.bottom + 100, // 顶部位置
            left: widget.rect.left, // 右边位置
          )
        ],
      ),
      onTap: () => Navigator.of(context).pop(), //点击空白处直接返回
    );
  }
}
