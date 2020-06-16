import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:play_android/ThemeUtils/ThemeUtils.dart';
import 'package:play_android/Responses/InformationFlowProtocol.dart';
import 'package:play_android/HttpUtils/Request.dart';
import 'package:play_android/Account/AccountManager.dart';

import 'package:play_android/Compose/ToastView.dart';

import 'BottomFunctionModel.dart';

class BottomFunctionView extends StatefulWidget {
  final InformationFlowProtocol _model;

  BottomFunctionView({
    Key key,
    @required InformationFlowProtocol model,
  })  : _model = model,
        super(key: key);

  @override
  _BottomFunctionViewState createState() => _BottomFunctionViewState();
}

class _BottomFunctionViewState extends State<BottomFunctionView> {
  List<BottomFunctionModel> _list = List<BottomFunctionModel>();

  @override
  void initState() {
    super.initState();
    _settingList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _list.length == 4 ? 160 : 260,
      color: Colors.black12,
      padding: EdgeInsets.all(15),
      alignment: Alignment.center,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: _createBottomSheetItem(_list[index]),
            onTap: () {
              _handleBottomSheetItemClick(_list[index]);
            },
          );
        },
        itemCount: _list.length,
      ),
    );
  }

  Widget _createBottomSheetItem(BottomFunctionModel model) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            model.iconData,
            color: ThemeUtils.currentColor,
            size: 32,
          ),
        ),
        Text(
          model.title,
          maxLines: 1,
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  void _handleBottomSheetItemClick(BottomFunctionModel model) {
    switch (model.type) {
      case BottomFunctionType.collect:
        _collect();
        break;
      case BottomFunctionType.unCollect:
        _unCollect();
        break;
      case BottomFunctionType.copyLink:
        _copyLink();
        break;
      case BottomFunctionType.openByBrowser:
        _openByBrowser();
        break;
      case BottomFunctionType.weChatShare:
        _weChatShare();
        break;
      case BottomFunctionType.refresh:
        _refresh();
        break;
    }
    Navigator.pop(context);
  }

  void _collect() async {
    var model = await Request.collectAction(id: widget._model.id);
    if (model.errorCode == 0) {
      ToastView.show("收藏成功");
      AccountManager.getInstance().info.collectIds.add(widget._model.id);
      widget._model.collect = true;
    } else {
      ToastView.show(model.errorMsg);
    }
  }

  //这个地方的取消收藏是失败的 
  //因为不管是在InformationFlowResponse中的DataInfo还是在BannerResponse中都没有originId这个属性
  //另外,这个收藏和取消收藏是一个全局的变量,这样的操作还是有问题,目前这个问题已经解决,自己手动对用户单例中的collectIds进行增删;其实也可以用过刷新登录接口解决;
  void _unCollect() async {
    var model = await Request.unCollectAction(originId: widget._model.id);
    if (model.errorCode == 0) {
      ToastView.show("取消收藏成功");
      if (AccountManager.getInstance().info.collectIds.contains(widget._model.id)) {
        AccountManager.getInstance().info.collectIds.remove(widget._model.id);
      }
      widget._model.collect = false;
    } else {
      ToastView.show(model.errorMsg);
    }
  }

  void _copyLink() {
    ClipboardData data = new ClipboardData(text: widget._model.link);
    Clipboard.setData(data);
    ToastView.show("复制成功");
  }

  void _openByBrowser() async {
    if (await canLaunch(widget._model.link)) {
      await launch(widget._model.link);
    } else {
      ToastView.show("无法打开该网页,请尝试复制");
    }
  }

  void _weChatShare() {
    ToastView.show("该功能暂未实现");
  }

  void _refresh() {
    ToastView.show("该功能暂未实现");
  }

  void _settingList() {
    var collectIds = AccountManager.getInstance().isLogin ? AccountManager.getInstance().info.collectIds : [];
    var collectId = widget._model.id;
    var isContain = collectIds.contains(collectId);
    widget._model.collect = isContain;
    if (!AccountManager.getInstance().isLogin) {
      _list
        ..add(BottomFunctionModel(
            title: "复制链接",
            iconData: Icons.link,
            type: BottomFunctionType.copyLink))
        ..add(BottomFunctionModel(
            title: "浏览器打开",
            iconData: Icons.open_in_browser,
            type: BottomFunctionType.openByBrowser))
        ..add(BottomFunctionModel(
            title: "微信分享",
            iconData: Icons.share,
            type: BottomFunctionType.weChatShare))
        ..add(BottomFunctionModel(
            title: "刷新",
            iconData: Icons.refresh,
            type: BottomFunctionType.refresh));
    } else {
      _list
        ..add(BottomFunctionModel(
            title: widget._model.collect ? "取消收藏" : "收藏",
            iconData: widget._model.collect ? Icons.favorite_border : Icons.favorite,
            type: widget._model.collect
                ? BottomFunctionType.unCollect
                : BottomFunctionType.collect))
        ..add(BottomFunctionModel(
            title: "复制链接",
            iconData: Icons.link,
            type: BottomFunctionType.copyLink))
        ..add(BottomFunctionModel(
            title: "浏览器打开",
            iconData: Icons.open_in_browser,
            type: BottomFunctionType.openByBrowser))
        ..add(BottomFunctionModel(
            title: "微信分享",
            iconData: Icons.share,
            type: BottomFunctionType.weChatShare))
        ..add(BottomFunctionModel(
            title: "刷新",
            iconData: Icons.refresh,
            type: BottomFunctionType.refresh));
    }
  }
}

