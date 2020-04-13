import 'dart:async';

import 'Api.dart';
import 'HttpUtils.dart';
import 'package:play_android/Models/BannerResponse.dart';

class RequestUtils {
  
  static Future<BannerResponse> getBanner() async {
    var json = await HttpUtils.get(api: Api.getBanner);
    return BannerResponse.fromJson(json);
  }
}