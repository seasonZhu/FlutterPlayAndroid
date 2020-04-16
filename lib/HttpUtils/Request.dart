import 'dart:async';
import 'dart:ffi';

import 'Api.dart';
import 'HttpUtils.dart';

import 'package:play_android/Responses/BannerResponse.dart';
import 'package:play_android/Responses/ArticleTopListResponse.dart';
import 'package:play_android/Responses/HotKeyResponse.dart';
import 'package:play_android/Responses/InformationFlowTopicResponse.dart';
import 'package:play_android/Responses/InformationFlowListResponse.dart';
//登录响应
//注册响应
import 'package:play_android/Responses/LogoutResponse.dart';
import 'package:play_android/Responses/CollectArticleActionResponse.dart';
//收藏文章列表响应
import 'package:play_android/Responses/RankListResponse.dart';
//个人获取积分的历史记录响应
//个人积分信息响应
/* 以上写了注释的与下面Future<Void>相对应,是需要登录后才能获取到的数据登录后再进行解析 */

// Dart的分类需要在Dart2.6以上的版本才能使用,修改了配置文件
extension Request on HttpUtils {
  // 获取轮播图数据
  static Future<BannerResponse> getBanner() async {
    var json = await HttpUtils.get(api: Api.getBanner);
    return BannerResponse.fromJson(json);
  }

  // 获取首页置顶文章
  static Future<ArticleTopListResponse> getTopArticleList() async {
    var json = await HttpUtils.get(api: Api.getTopArticleList);
    return ArticleTopListResponse.fromJson(json);
  }

  // 通过page获取首页文章
  static Future<InformationFlowListResponse> getArticleList({int page}) async {
    var json = await HttpUtils.get(api: Api.getArticleList + page.toString() + "/json");
    return InformationFlowListResponse.fromJson(json);
  }

  // 搜索热词
  static Future<HotKeyResponse> getSearchHotKey() async {
    var json = await HttpUtils.get(api: Api.getSearchHotKey);
    return HotKeyResponse.fromJson(json);
  }

  // 通过关键词与page进行搜索,获取搜索结果
  static Future<InformationFlowListResponse> postQueryKey({int page, String keyword}) async {
    Map<String, String> params = Map();
    params["k"] = keyword;
    var json = await HttpUtils.post(api: Api.postQueryKey + page.toString() + "/json", params: params);
    return InformationFlowListResponse.fromJson(json);
  }

  // 项目分类
  static Future<InformationFlowTopicResponse> getProjectClassify() async {
    var json = await HttpUtils.get(api: Api.getProjectClassify);
    return InformationFlowTopicResponse.fromJson(json);
  }

  // 通过id与page获取单个项目分类的列表
  static Future<InformationFlowListResponse> getProjectClassifyList({int page, int id}) async {
    Map<String, String> params = Map();
    params["cid"] = id.toString();
    var json = await HttpUtils.get(api: Api.getProjectClassifyList + page.toString() + "/json", params: params);
    return InformationFlowListResponse.fromJson(json);
  }

  // 公众号分类
  static Future<InformationFlowTopicResponse> getPubilicNumber() async {
    var json = await HttpUtils.get(api: Api.getPubilicNumber);
    return InformationFlowTopicResponse.fromJson(json);
  }

  // 通过id与page获取单个公众号分类的列表
  static Future<InformationFlowListResponse> getPubilicNumberList({int page, int id}) async {
    var json = await HttpUtils.get(api: Api.getPubilicNumberList + id.toString() + "/" + page.toString() + "/json");
    return InformationFlowListResponse.fromJson(json);
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
  
  // 积分排行榜
  static Future<RankListResponse> getRankingList({int page}) async {
    var json = await HttpUtils.get(api: Api.getRankingList + page.toString() + "/json");
    return RankListResponse.fromJson(json);
  }

  // 个人获取积分的历史记录
  static Future<Void> getCoinList({int page}) async {
    var json = await HttpUtils.get(api: Api.getCoinList + page.toString() + "/json");
    print(json);
  }
  
  // 个人积分信息
  static Future<Void> getUserCoinInfo() async {
    var json = await HttpUtils.get(api: Api.getUserCoinInfo);
    print(json);
  }
}