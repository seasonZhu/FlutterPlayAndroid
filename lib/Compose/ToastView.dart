import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastView {
  static void show(String message) {
    // 看了Fluttertoast的源代码,是发了一个消息给原生,最后由原生实现
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.black38,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  // 系统的SnackBar
  static void showSnackBar(BuildContext context, String msg) {
    Scaffold.of(context).showSnackBar(
      SnackBar(content: Text("$msg")),
    );
  }

  static void removeCurrentSnackBar(BuildContext context) {
    Scaffold.of(context).removeCurrentSnackBar();
  }
}
