import 'dart:async';

import 'package:dio/dio.dart';

import 'Api.dart';

class HttpUtils {
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