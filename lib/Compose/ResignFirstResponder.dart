import 'package:flutter/material.dart';

// 取消第一响应者 iOS的一点私货
class ResignFirstResponder {
  static of(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}