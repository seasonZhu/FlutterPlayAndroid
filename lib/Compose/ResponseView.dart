import 'package:flutter/material.dart';

import 'package:play_android/Responses/BaseResponse.dart';
import 'package:play_android/Responses/ResponseState.dart';
import 'LoadingView.dart';
import 'ErrorView.dart';
import 'EmptyView.dart';

typedef WidgetCallback = Widget Function();

/*
响应View,这个view和网络请求的回调紧密联系,是我经过几次思考后得出的方案
 */
class ResponseView<T extends BaseResponse> extends StatefulWidget {

  final T response;
  
  final WidgetCallback contentBuilder;

  get value {
    int _value;
    switch (response.responseState) {
      case ResponseState.loading:
        _value = response.responseState.value;
        break;
      case ResponseState.success:
        _value = response.successState.value;
        break;
      case ResponseState.fail:
        _value = response.responseState.value;
        break;
    }
    return _value;
  }

  ResponseView({@required this.response, @required this.contentBuilder});

  @override
  _ResponseViewState createState() => _ResponseViewState();
}

class _ResponseViewState extends State<ResponseView> {

  // 只要可以用只读计算属性进行初始化,我们都还是好朋友
  get body {
    var _body = IndexedStack(
      children: [
        LoadingView(),
        ErrorView(),
        widget.contentBuilder(),
        EmptyView()
      ],
      index: widget.value,
    );
    return _body;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.response == null) {
      return LoadingView();
    }
    return body;
  }
}