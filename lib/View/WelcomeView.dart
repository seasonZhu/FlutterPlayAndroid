import 'package:flutter/material.dart';

import 'package:play_android/Compose/CustomRoute.dart';
import 'package:play_android/Account/AccountManager.dart';
import 'MainView.dart';

class WelcomeView extends StatefulWidget {
  @override
  _WelcomeViewState createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  int _selectedIndex = 0;

  get _pages {
    return PageView(
      physics: ClampingScrollPhysics(),
      children: _views,
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }

  get _pageController {
    return PageController(initialPage: _selectedIndex);
  }

  get _views {
    // return [
    //   "welcome_2.jpg",
    //   "welcome_1.png",
    // ].map((imageName) => _welcomeView(imageName)).toList();

    return [
      _otherWelcomeView("welcome_2.jpg"),
      _lastWelcomeView("welcome_1.png"),
    ];
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages,
    );
  }

  Widget _welcomeView(String imageName) {
    var size = MediaQuery.of(context).size;
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: <Widget>[
        Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            //设置背景图片
            image: DecorationImage(
              image: AssetImage("assets/images/$imageName"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          bottom: 44,
          /* 不论是使用Offstage还是Opacity 都达不到非常好的效果, 感觉还是单独写好*/
          // child: Offstage(
          //   offstage: _selectedIndex == 0,
          //   child: FlatButton(
          //     child: Text("点击进入"),
          //     color: Colors.grey,
          //     shape: RoundedRectangleBorder(
          //         side: BorderSide.none,
          //         borderRadius: BorderRadius.all(Radius.circular(20))),
          //     onPressed: () {
          //       _goMainView();
          //     },
          //   ),
          // ),
          child: Opacity(
            opacity: _selectedIndex == 1 ? 1 : 0,
            child: TextButton(
              child: Text("点击进入"),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.grey),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
              ),
              onPressed: () {
                _goMainView();
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _otherWelcomeView(String imageName) {
    var size = MediaQuery.of(context).size;
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: <Widget>[
        Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            //设置背景图片
            image: DecorationImage(
              image: AssetImage("assets/images/$imageName"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  Widget _lastWelcomeView(String imageName) {
    var size = MediaQuery.of(context).size;
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: <Widget>[
        Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            //设置背景图片
            image: DecorationImage(
              image: AssetImage("assets/images/$imageName"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          bottom: 44,
          child: TextButton(
            child: Text("点击进入"),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
            ),
            onPressed: () {
              _goMainView();
            },
          ),
        ),
      ],
    );
  }

  void _goMainView() {
    AccountManager.getInstance().saveNotFirstLanuch();
    Navigator.pushAndRemoveUntil(
      context,
      CustomRoute(type: TransitionType.fade, widget: MainView()),
      (route) => route == null,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
