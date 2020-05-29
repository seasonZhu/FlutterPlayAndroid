import 'package:flutter/material.dart';

import 'package:play_android/ThemeUtils/ThemeUtils.dart';
import 'package:play_android/HttpUtils/Request.dart';
import 'package:play_android/Responses/HotKeyResponse.dart';

import 'package:play_android/Compose/LoadingView.dart';
import 'package:play_android/Compose/ToastView.dart';
import 'package:play_android/Compose/EmptyView.dart';
import 'package:play_android/Compose/ResignFirstResponder.dart';

import 'package:play_android/View/Routes.dart';
import 'package:play_android/View/PlayAndroidApp.dart';

class HotKeyView extends StatefulWidget {
  @override
  _HotKeyViewState createState() => _HotKeyViewState();
}

class _HotKeyViewState extends State<HotKeyView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            height: 33,
            child: _SearchField(
              keywordCallback: (keyword) {
                _pushToSearchResultView(keyword);
              },
            ),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0.1,
        ),
        body: futureBuilder(),
      ),
      onTap: () {
        ResignFirstResponder.of(context);
      },
    );
  }

  Widget futureBuilder() {
    return FutureBuilder(
        future: getSearchHotKey(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //请求完成
          if (snapshot.connectionState == ConnectionState.done) {
            HotKeyResponse model = snapshot.data;

            if (model.errorCode == 0) {
              return Wrap(
                children: _buttons(model),
              );
            } else if (model.data.isEmpty) {
              return EmptyView();
            } else {
              ToastView.show(model.errorMsg);
              return Container();
            }
          }
          //请求未完成时弹出loading
          return LoadingView();
        });
  }

  Future<HotKeyResponse> getSearchHotKey() async {
    var model = await Request.getSearchHotKey();
    return model;
  }

  List<Widget> _buttons(HotKeyResponse model) {
    return model.data.map((data) => _button(data)).toList();
  }

  Widget _button(Datum data) {
    return Container(
      margin: EdgeInsets.all(5),
      child: FlatButton(
        color: ThemeUtils.currentColor,
        highlightColor: ThemeUtils.currentColor,
        colorBrightness: Brightness.dark,
        splashColor: ThemeUtils.currentColor,
        child: Text(data.name),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed: () {
          _pushToSearchResultView(data.name);
        },
      ),
    );
  }

  void _pushToSearchResultView(String keyword) {
    // 我目前还没有想到特别好的办法,需要研究FutureBuilder在上下刷新中的使用
    Routes.arguments = keyword;
    Navigator.pushNamed(context, Routes.searchResultView, arguments: keyword);
  }
}

class _SearchField extends StatelessWidget {
  final searchKeyCtrl = TextEditingController(text: '');

  final ValueChanged<String> _keywordCallback;

  _SearchField({Key key, ValueChanged<String> keywordCallback})
      : _keywordCallback = keywordCallback,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Expanded(
            child: TextField(
                keyboardType: TextInputType.text,
                controller: searchKeyCtrl,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                    focusColor: Colors.white,
                    hintText: "请输入搜索关键字",
                    hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                    border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(4.0))),
                    contentPadding: const EdgeInsets.all(4.0)),
                onEditingComplete: () {
                  _inputComplete(context);
                },
                onSubmitted: (input) {
                  print(input);
                }),
          ),
        ),
        InkWell(
          child: Container(
            margin: EdgeInsets.only(left: 10),
            width: 50,
            height: 30,
            alignment: Alignment.center,
            child: Text(
              '搜索',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
          onTap: () {
            _inputComplete(context);
          },
        )
      ],
    );
  }

  void _inputComplete(BuildContext context) {
    ResignFirstResponder.of(context);
    if (searchKeyCtrl.text.trim().isEmpty) {
      ToastView.show("搜索关键字不能为空");
      return;
    }
    _keywordCallback(searchKeyCtrl.text.trim());
  }

  // 已经通过回调,到所谓的控制器层面去进行push了,另外发现了stf控件context用不传,但是stl控件context非传不可
  /* 
    void _pushToSearchResultView(BuildContext context) {
    Navigator.pushNamed(context, Routes.searchResultView);
  }
   */

}
