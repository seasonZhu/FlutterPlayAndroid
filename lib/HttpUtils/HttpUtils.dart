import 'dart:async';

import 'package:dio/dio.dart';

import 'Api.dart';

abstract class HttpUtils {
  // 超时时间 1min dio中是以毫秒计算的
  static var timeout = 60000;

  static Dio _dio = Dio(BaseOptions(
    baseUrl: Api.baseUrl,
    connectTimeout: timeout,
    receiveTimeout: timeout,
    headers: {},
  ));

  // Get请求
  static Future<Map<String, dynamic>> get({String api, Map<String, dynamic> params}) async {
    Response response = await _dio.get(api, queryParameters: params);
    return response.data;
  }

  // Post请求
  static Future<Map<String, dynamic>> post({String api, Map<String, dynamic> params}) async {
    Response response = await _dio.post(api, queryParameters: params);
    return response.data;
  }
}

extension BaseRequest on HttpUtils {
  /* Dart的语言限制了泛型更广泛的使用,Future包裹的需要的是一个具体类型,而下面的这种写法无法通过
  static Future<T implements BaseResponse> getBaseResponse({String api, Map<String, dynamic> params}) async {
    Map<String, dynamic> json = await get(api: api, params: params);
    return BaseResponse(json);
  }

  static Future<T implements BaseResponse> postBaseResponse({String api, Map<String, dynamic> params}) async {
    Map<String, dynamic> json = await post(api: api, params: params);
    return BaseResponse(json);
  }
   */
}