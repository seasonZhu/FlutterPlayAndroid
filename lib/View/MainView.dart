import 'package:flutter/material.dart';

import 'package:play_android/HttpUtils/Request.dart';
import 'package:play_android/Account/AccountManager.dart';
import 'package:play_android/EventBus/EventBus.dart';

import 'package:play_android/Home/HomeView.dart';
import 'package:play_android/Information/InformationType.dart';
import 'package:play_android/Information/InformationFlowTopicView.dart';
import 'package:play_android/My/MyView.dart';
import 'package:play_android/ExampleView/View/TestView.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

// 有关于SingleTickerProviderStateMixin,最后可以追溯到TickerProvider,这个协议作用是阻止在屏幕锁定时,执行动画以避免必要的资源浪费
class _MainViewState extends State<MainView>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  final _views = [
    HomeView(),
    InformationFlowTopicView(
      type: InformationType.project,
    ),
    InformationFlowTopicView(
      type: InformationType.publicNumber,
    ),
    MyView(),
    TestView()
  ];

  final _bottomNavigationBarItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
    BottomNavigationBarItem(
        icon: Icon(Icons.perm_contact_calendar), label: "项目"),
    BottomNavigationBarItem(
        icon: Icon(Icons.account_balance_wallet), label: "公众号"),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: "我的"),
    BottomNavigationBarItem(icon: Icon(Icons.train), label: "测试"),
  ];

  get _body {
    // 通过这个方案保证tabbar的四个页面都保持存活状态,避免反复刷新,这里其实四个页面落在一起,通过index控制是否显示
    // IndexedStack是Stack的子类，Stack是将所有的子组件叠加显示，而IndexedStack只显示指定的子组件
    var body = IndexedStack(
      children: _views,
      index: _selectedIndex,
    );

    return body;
  }

  /* 
    使用这个是没有问题的,但是涉及自动登录的总线是不会传递到MyView里面的
    在使用的_pages的时候,是先自动登录,fire之后,点击到我的界面,我的界面才initState
    而使用_body的时候,是我的页面先initState,然后再自动登录,fire,所以能接收到
    优化的方案倒是有,就是在MyView界面直接使用AccountManager单例里面的变量即可
   */
  Widget get pages {
    var pages = PageView(
      physics: ClampingScrollPhysics(),
      children: _views,
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          _selectedIndex = index; //刷新界面
        });
      },
    );
    return pages;
  }

  var _pageController;

  var brightnessType;

  @override
  void initState() {
    super.initState();
    autoLogin();
    _listenThemeMode();
    //pageViewControllerAndListener();

    AccountManager.getInstance().getIsOpenDardMode().then((isOpenDarkMode) {
      setState(() {
        isOpenDarkMode
          ? brightnessType = Brightness.dark
          : brightnessType = Brightness.light;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body, //_pages
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavigationBarItems,
        currentIndex: _selectedIndex, //默认选中的 index
        fixedColor: _bottomNavigationBarItemColor(),
        type: BottomNavigationBarType.fixed, //类型为 fixed
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; //刷新界面
    });
    //pageViewScrollToSelectedIndexPage();
  }

  void autoLogin() async {
    var username = await AccountManager.getInstance().getLastLoginUserName();
    var password = await AccountManager.getInstance().getLastLoginPassword();
    if (username.isNotEmpty && password.isNotEmpty) {
      var model = await Request.login(username: username, password: password);
      if (model.errorCode == 0) {
        eventBus.fire(LoginEvent());
        AccountManager.getInstance()
            .save(info: model.data, isLogin: true, password: password);
      }
    }
  }

  void _listenThemeMode() {
    eventBus.on<ChangeThemeBrightness>().listen((event) {
      setState(() {
        brightnessType = event.brightnessType;
      });
    });
  }

  Color _bottomNavigationBarItemColor() {
    return brightnessType == Brightness.light
        ? Theme.of(context).primaryColor
        : Colors.white38;
  }

  // pageView跳转到指定页面去
  void pageViewScrollToSelectedIndexPage() {
    var offset = MediaQuery.of(context).size.width * _selectedIndex;
    _pageController.animateTo(offset,
        duration: Duration(milliseconds: 200), curve: Curves.linear);
  }

  // PageController的初始化与监听
  void pageViewControllerAndListener() {
    _pageController = PageController(initialPage: _selectedIndex);
    _pageController.addListener(() {
      print("offset: ${_pageController.offset}");
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
