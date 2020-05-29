/*
 * @Author: your name
 * @Date: 2020-04-15 09:45:47
 * @LastEditTime: 2020-05-29 11:21:17
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /play_android/lib/View/Routes.dart
 */ 
// 路由表
abstract class Routes {
  // 系统默认'/'是根view,这个不能更改
  static final root = "/";

  static final rankingView = "/rankingView";

  static final informationFlowWebView = "/informationFlowWebView";

  static final hotKeyView = "/hotKeyView";

  static final searchResultView = "/searchResultView";

  static final myDetailView = "/myDetailView";

  static final myCoinView = "/myCoinView";

  static final myCollectView = "/myCollectView";

  static final themeSettingView = "/themeSettingView";

  static final aboutAppAndMeView = "/aboutAppAndMeView";

  static final loginView = "/loginView";

  static final registerView = "/registerView";

  static final todayHotNavigatorView = "/todayHotNavigatorView";

  static final mixinCountView = "/mixinCountView";
}