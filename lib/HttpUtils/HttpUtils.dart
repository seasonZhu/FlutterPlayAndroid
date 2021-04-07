import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'Api.dart';
import 'package:play_android/Account/AccountManager.dart';

// 这个是用来判断是否是生产环境
const bool inProduction = const bool.fromEnvironment("dart.vm.product");

abstract class HttpUtils {
  // 超时时间 1min dio中是以毫秒计算的
  static var timeout = 60000000;

  HttpUtils._();

  static Dio _dio = Dio(
    BaseOptions(
      baseUrl: Api.baseUrl,
      connectTimeout: timeout,
      receiveTimeout: timeout,
      headers: {},
    ),
  ).addPrettyPrint;

  // Get请求
  static Future<Map<String, dynamic>> get(
      {String api,
      Map<String, dynamic> params,
      Map<String, dynamic> headers = const {}}) async {
    getCookieHeaderOptions().headers.addAll(headers);
    Response response = await _dio.get(api,
        queryParameters: params, options: getCookieHeaderOptions());
    Map<String, dynamic> json = response.data;
    return json;
  }

  // Post请求
  static Future<Map<String, dynamic>> post(
      {String api,
      Map<String, dynamic> params,
      Map<String, dynamic> headers = const {}}) async {
    getCookieHeaderOptions().headers.addAll(headers);
    Response response =
        await _dio.post(api, data: params, options: getCookieHeaderOptions());
    Map<String, dynamic> json = response.data;
    return json;
  }

  static Options getCookieHeaderOptions() {
    var value = AccountManager.getInstance().cookieHeaderValue;
    Options options = Options(headers: {HttpHeaders.cookieHeader: value});
    return options;
  }
}

extension AddPrettyPrint on Dio {
  Dio get addPrettyPrint {
    this.interceptors.add(
          PrettyDioLogger(
            requestHeader: false,
            requestBody: true,
            responseBody: true,
            responseHeader: false,
            compact: false,
          ),
        );
    return this;
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
