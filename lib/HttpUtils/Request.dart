import 'dart:async';

import 'Api.dart';
import 'HttpUtils.dart';

import 'package:play_android/Models/BannerResponse.dart';

// Dart的分类需要在Dart2.6以上的版本才能使用,修改了配置文件
extension Request on HttpUtils {
  // 获取轮播图数据
  static Future<BannerResponse> getBanner() async {
    var json = await HttpUtils.get(api: Api.getBanner);
    return BannerResponse.fromJson(json);
  }
}