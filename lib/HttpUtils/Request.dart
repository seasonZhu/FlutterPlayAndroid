import 'dart:async';
import 'dart:ffi';

import 'Api.dart';
import 'HttpUtils.dart';

import 'package:play_android/Responses/BannerResponse.dart';
import 'package:play_android/Responses/ArticleListResponse.dart';
import 'package:play_android/Responses/HotKeyResponse.dart';
import 'package:play_android/Responses/SearchResultResponse.dart';
import 'package:play_android/Responses/ProjectClassifyResponse.dart';
import 'package:play_android/Responses/ProjectClassifyListResponse.dart';
import 'package:play_android/Responses/PublicNumberResponse.dart';
import 'package:play_android/Responses/PublicNumberListResponse.dart';
//登录响应
//注册响应
import 'package:play_android/Responses/LogoutResponse.dart';
import 'package:play_android/Responses/CollectArticleActionResponse.dart';
//收藏文章列表响应

// Dart的分类需要在Dart2.6以上的版本才能使用,修改了配置文件
extension Request on HttpUtils {
  // 获取轮播图数据
  static Future<BannerResponse> getBanner() async {
    var json = await HttpUtils.get(api: Api.getBanner);
    return BannerResponse.fromJson(json);
  }

  // 获取首页置顶文章
  static Future<ArticleListResponse> getTopArticleList() async {
    var json = await HttpUtils.get(api: Api.getTopArticleList);
    return ArticleListResponse.fromJson(json);
  }

  // 通过page获取首页文章
  static Future<ArticleListResponse> getArticleList({int page}) async {
    var json = await HttpUtils.get(api: Api.getArticleList + page.toString() + "/json");
    return ArticleListResponse.fromJson(json);
  }

  // 搜索热词
  static Future<HotKeyResponse> getSearchHotKey() async {
    var json = await HttpUtils.get(api: Api.getSearchHotKey);
    return HotKeyResponse.fromJson(json);
  }

  // 通过关键词与page进行搜索,获取搜索结果
  static Future<SearchResultResponse> postQueryKey({int page, String keyWord}) async {
    Map<String, String> params = Map();
    params["k"] = keyWord;
    var json = await HttpUtils.post(api: Api.postQueryKey + page.toString() + "/json", params: params);
    return SearchResultResponse.fromJson(json);
  }

  // 项目分类
  static Future<ProjectClassifyResponse> getProjectClassify() async {
    var json = await HttpUtils.get(api: Api.getProjectClassify);
    return ProjectClassifyResponse.fromJson(json);
  }

  // 通过id与page获取单个项目分类的列表
  static Future<ProjectClassifyListResponse> getProjectClassifyList({int page, int id}) async {
    Map<String, String> params = Map();
    params["cid"] = id.toString();
    var json = await HttpUtils.get(api: Api.getProjectClassifyList + page.toString() + "/json", params: params);
    return ProjectClassifyListResponse.fromJson(json);
  }

  // 公众号分类
  static Future<PublicNumberResponse> getPubilicNumber() async {
    var json = await HttpUtils.get(api: Api.getPubilicNumber);
    return PublicNumberResponse.fromJson(json);
  }

  // 通过id与page获取单个公众号分类的列表
  static Future<PublicNumberListResponse> getPubilicNumberList({int page, int id}) async {
    var json = await HttpUtils.get(api: Api.getPubilicNumberList + id.toString() + "/" + page.toString() + "/json");
    return PublicNumberListResponse.fromJson(json);
  }

  // 登录
  static Future<Void> login({String username, String password}) async {
    Map<String, String> params = Map();
    params["username"] = username;
    params["password"] = password;
    var json = await HttpUtils.post(api: Api.postLogin, params: params);
    print(json);
  }

  // 注册
  static Future<Void> register({String username, String password, String rePassword}) async {
    Map<String, String> params = Map();
    params["username"] = username;
    params["password"] = password;
    params["repassword"] = rePassword;
    var json = await HttpUtils.post(api: Api.postRegister, params: params);
    print(json);
  }

  // 登出
  static Future<LogoutResponse> logout() async {
    var json = await HttpUtils.get(api: Api.getLogout);
    return LogoutResponse.fromJson(json);
  }

  // 文章收藏与取消收藏操作
  static Future<CollectArticleActionResponse> collectAction({int id, bool isCollect}) async {
    var api = isCollect ? Api.postCollectArticle : Api.postUnCollectArticle;
    var json = await HttpUtils.post(api: api + id.toString() + "/json");
    return CollectArticleActionResponse.fromJson(json);
  }

  // 收藏文章列表
  static Future<Void> getCollectArticleList({int page}) async {
    var json = await HttpUtils.get(api: Api.getCollectArticleList + page.toString() + "/json");
    print(json);
  }
  
}