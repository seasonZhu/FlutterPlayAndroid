import 'package:flutter/material.dart';

import 'package:play_android/ThemeUtils/ThemeUtils.dart';
import 'package:play_android/HttpUtils/Request.dart';
import 'package:play_android/Responses/HotKeyResponse.dart';

import 'package:play_android/Compose/LoadingView.dart';
import 'package:play_android/Compose/ToastView.dart';
import 'package:play_android/Compose/EmptyView.dart';
import 'package:play_android/Compose/ResignFirstResponder.dart';

import 'package:play_android/View/Routes.dart';

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
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(ThemeUtils.currentColor),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          overlayColor: MaterialStateProperty.all(ThemeUtils.currentColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        child: Text(data.name),
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
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.text,
                controller: searchKeyCtrl,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                    focusColor: Colors.white,
                    hintText: " 请输入搜索关键字",
                    hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                    border: OutlineInputBorder(
                      ///设置边框四个角的弧度
                      borderRadius: BorderRadius.all(Radius.circular(4)),

                      ///用来配置边框的样式
                      borderSide: BorderSide(
                        ///设置边框的颜色
                        color: Colors.white,

                        ///设置边框的粗细
                        width: 1.0,
                      ),
                    ),

                    ///设置输入框可编辑时的边框样式
                    enabledBorder: OutlineInputBorder(
                      ///设置边框四个角的弧度
                      borderRadius: BorderRadius.all(Radius.circular(4)),

                      ///用来配置边框的样式
                      borderSide: BorderSide(
                        ///设置边框的颜色
                        color: Colors.white,

                        ///设置边框的粗细
                        width: 1.0,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      ///设置边框四个角的弧度
                      borderRadius: BorderRadius.all(Radius.circular(10)),

                      ///用来配置边框的样式
                      borderSide: BorderSide(
                        ///设置边框的颜色
                        color: Colors.red,

                        ///设置边框的粗细
                        width: 1.0,
                      ),
                    ),

                    ///用来配置输入框获取焦点时的颜色
                    focusedBorder: OutlineInputBorder(
                      ///设置边框四个角的弧度
                      borderRadius: BorderRadius.all(Radius.circular(4)),

                      ///用来配置边框的样式
                      borderSide: BorderSide(
                        ///设置边框的颜色
                        color: Colors.transparent,

                        ///设置边框的粗细
                        width: 1.0,
                      ),
                    ),
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
