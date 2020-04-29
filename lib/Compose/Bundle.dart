abstract class Bundle {
  static var imagePath = "assets/images/";

  static String imageName(String name, { String format = "png"}) {
    return '$imagePath$name.$format';
  }
}

/*
import 'package:flutter/material.dart';

// 由于这个Image.asset函数有非常多的参数,我这样写分类反而丧失了原有函数的输入参数
extension LocalImage on Image {
  static var path = "assets/images/";

  static Image local({@required String name, String format = "png"}) {
    var imagePath = '$path$name.$format';
    return Image.asset(imagePath);
  }
}
*/