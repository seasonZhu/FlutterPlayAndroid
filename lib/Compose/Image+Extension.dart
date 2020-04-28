import 'package:flutter/material.dart';

extension LocalImage on Image {
  static var path = "assets/images/";

  static Image local({@required String name, String format = "png"}) {
    var imagePath = '$path$name.$format';
    return Image.asset(imagePath);
  }
}