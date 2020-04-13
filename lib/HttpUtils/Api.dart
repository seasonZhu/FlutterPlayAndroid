abstract class Api {
  static const String baseUrl = 'https://www.wanandroid.com/';

  // 首页banner
  static const String getBanner = baseUrl + 'banner/json';

  // 首页文章列表
  static const String getArticleList = baseUrl + 'article/list/';

  // 首页置顶文章列表
  static const String getTopArticleList = baseUrl + 'article/top/json';

  // 首页搜索热词
  static const String getSearchHotKey = baseUrl + 'hotkey/json';

  //搜索 https://www.wanandroid.com/article/query/0/json
  static const String postQueryKey = baseUrl + 'article/query/';

  // 项目分类
  static const String getProjectClassify = baseUrl + 'project/tree/json';

  // 项目分类列表
  static const String getProjectClassifyList  = baseUrl + 'project/list/';

  // 公众号
  static const String getPubilicNumber = baseUrl + 'wxarticle/chapters/json';

  // 公众号文章列表
  static const String getPubilicNumberList = baseUrl + 'wxarticle/list/';

  // 登录
  static const String postLogin = baseUrl + 'user/login';

  // 注册
  static const String postRegister = baseUrl + 'user/register';

  // 登录退出
  static const String getLogout = baseUrl + 'user/logout/json';

  // 收藏站内文章 lg/collect/1165/json
  static const String postCollectArticle = baseUrl + 'lg/collect/';

  // 取消收藏站内文章 lg/collect/1165/json
  static const String postUnCollectArticle = baseUrl + 'lg/uncollect_originId/';

  // 收藏文章列表
  static const String getCollectArticleList = baseUrl + 'lg/collect/list/';

  // 积分排行榜 lg/coin/list/1/json
  static const String getRankingList = baseUrl + 'coin/rank/';

  // 个人积分获取列表
  static const String getCoinList = baseUrl + 'lg/coin/list/';

  // 个人积分
  static const String getUserCoinInfo = baseUrl + 'lg/coin/userinfo/json';

}