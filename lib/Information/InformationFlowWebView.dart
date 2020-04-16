import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:flutter_html/flutter_html.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'package:play_android/Responses/InformationFlowProtocol.dart';

import 'package:play_android/Compose/Marquee.dart';

class InformationFlowWebView extends StatefulWidget {
  @override
  _InformationFlowWebViewState createState() => _InformationFlowWebViewState();
}

// 使用的WebviewScaffold这个框架中无法支持iOS的侧滑,准确说的是web表现的内容无法侧滑
class _InformationFlowWebViewState extends State<InformationFlowWebView> {
  FlutterWebviewPlugin _flutterWebviewPlugin = FlutterWebviewPlugin();

  InformationFlowProtocol _model;

  var _isLoading = true;

  @override
  void initState() {
    super.initState();
    _startWebViewListen();
  }

  Widget marqueeText() {
    return Container(
      width: 100,
      child: Marquee(Text(_model.title, style: TextStyle(color: Colors.white)),
          200.0, Duration(seconds: 2), 230.0),
    );
  }

  Widget normalText() {
    return SingleChildScrollView(child: Text(_model.title, style: TextStyle(color: Colors.white)),scrollDirection: Axis.horizontal,);
  }

  Widget loading() {
    return Container(
      width: 10, 
      height: 10, 
      child: CupertinoActivityIndicator()
    );
  }

  @override
  Widget build(BuildContext context) {
    _model = ModalRoute.of(context).settings.arguments;

    return WebviewScaffold(
      url: _model.link,
      appBar: AppBar(
        // 参考了微信的做法,直接就没有标题,这个title有h5元素,
        //用Text或者框架Html都不能很好解决,加上跑马灯的问题
        //title: normalText(),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.1,
        actions: <Widget>[
          _isLoading ? loading() : Container(),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {})
        ],
      ),
      withJavascript: true,
      //允许执行js
      withLocalStorage: true,
      //允许本地存储
      withZoom: true,
      //允许网页缩放
      bottomNavigationBar: null,
    );
  }

  void _startWebViewListen() {
    //监听url变化
    _flutterWebviewPlugin.onStateChanged.listen((state) {
      if (state.type == WebViewState.finishLoad) {
        if (!mounted) return;
        setState(() {
          _isLoading = false;
        });
      } else if (state.type == WebViewState.startLoad) {
        if (mounted) {
          setState(() {
            _isLoading = true;
          });
        }
      }
    });
  }
}
