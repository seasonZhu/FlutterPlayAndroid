import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:play_android/Responses/InformationFlowProtocol.dart';
import 'BottomFunctionView.dart';

class InformationFlowWebView extends StatefulWidget {
  @override
  _InformationFlowWebViewState createState() => _InformationFlowWebViewState();
}

// 使用的WebviewScaffold这个框架中无法支持iOS的侧滑,准确说的是web表现的内容无法侧滑
// 后面使用了webview_flutter这个框架,最终调用的是原生的WKWebKit框架,效果好,并且支持侧滑
class _InformationFlowWebViewState extends State<InformationFlowWebView> {
  FlutterWebviewPlugin _flutterWebviewPlugin = FlutterWebviewPlugin();

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  InformationFlowProtocol _model;

  var _isLoading = true;

  @override
  void initState() {
    super.initState();
    //_startWebViewListen();
  }

  Widget normalText() {
    return SingleChildScrollView(
      child: Text(_model.title, style: TextStyle(color: Colors.white)),
      scrollDirection: Axis.horizontal,
    );
  }

  Widget loading() {
    return Container(
        width: 10, height: 10, child: CupertinoActivityIndicator());
  }

  @override
  Widget build(BuildContext context) {
    _model = ModalRoute.of(context).settings.arguments;
    return scaffold();
  }

  AppBar appBar() {
    return AppBar(
      // 参考了微信的做法,直接就没有标题,这个title有h5元素,
      //用Text或者框架Html都不能很好解决,加上跑马灯的问题
      //title: normalText(),
      iconTheme: IconThemeData(color: Colors.white),
      elevation: 0.1,
      actions: <Widget>[
        _isLoading ? loading() : Container(),
        IconButton(icon: Icon(Icons.more_vert), onPressed: () {
          showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BottomFunctionView(model: _model);
      },
    );
        })
      ],
    );
  }

  Scaffold scaffold() {
    return Scaffold(
      appBar: appBar(),
      // We're using a Builder here so we have a context that is below the Scaffold
      // to allow calling Scaffold.of(context) so we can show a snackbar.
      body: SafeArea(
        child: Builder(builder: (BuildContext context) {
          return WebView(
            initialUrl: _model.link,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            // Remove this when collection literals makes it to stable.
            // ignore: prefer_collection_literals
            navigationDelegate: (NavigationRequest request) {
              if (request.url.startsWith('https://www.youtube.com/')) {
                print('blocking navigation to $request}');
                return NavigationDecision.prevent;
              }
              print('allowing navigation to $request');
              return NavigationDecision.navigate;
            },
            onPageStarted: (String url) {
              print('Page started loading: $url');
              setState(() {
                _isLoading = true;
              });
            },
            onPageFinished: (String url) {
              print('Page finished loading: $url');
              setState(() {
                _isLoading = false;
              });
            },
            gestureNavigationEnabled: true,
          );
        }),
      ),
    );
  }

  /* 
  以下方法没有用到
   */

  WebviewScaffold webviewPlugin() {
    return WebviewScaffold(
      url: _model.link,
      appBar: appBar(),
      withJavascript: true,
      //允许执行js
      withLocalStorage: true,
      //允许本地存储
      withZoom: true,
      //允许网页缩放
      bottomNavigationBar: null,
    );
  }

  void startWebViewListen() {
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
