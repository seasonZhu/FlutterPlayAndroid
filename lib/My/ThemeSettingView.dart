import 'package:flutter/material.dart';

import 'package:play_android/EventBus/EventBus.dart';
import 'package:play_android/ThemeUtils/ThemeUtils.dart';
import 'MyListModel.dart';
import 'package:play_android/Account/AccountManager.dart';

class ThemeSettingView extends StatefulWidget {
  @override
  _ThemeSettingViewState createState() => _ThemeSettingViewState();
}

// 本页面显示了一个stf控件的LifeCycle
class _ThemeSettingViewState extends State<ThemeSettingView> {
  List<Color> colors = ThemeUtils.supportColors;

  var _selectIndex;

  changeColorTheme(Color c) {
    eventBus.fire(ChangeThemeEvent(c));
  }

  @override
  void initState() {
    super.initState();
    _setLastSelectIndex();
    print("initState");
  }

  @override
  Widget build(BuildContext context) {
    MyListModel model = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text(model.title, style: TextStyle(color: Colors.white)),
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true, //设置标题是否局中
        ),
        body: Padding(
            padding: const EdgeInsets.all(4.0),
            child: GridView.count(
              crossAxisCount: 4,
              children: List.generate(colors.length, (index) {
                return InkWell(
                  onTap: () {
                    ThemeUtils.currentColor = colors[index];
                    changeColorTheme(colors[index]);
                    AccountManager.getInstance()
                        .saveLastThemeSettingIndex(index);
                    setState(() {
                      _selectIndex = index;
                    });
                  },
                  child: _colorBlock(index),
                );
              }),
            )
        )
    );
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }

  @override
  void didUpdateWidget(ThemeSettingView oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  void reassemble() {
    super.reassemble();
    print("reassemble");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  // 显示可选择的色块,使用了Stack和Opacity
  Widget _colorBlock(int index) {
    return Container(
      margin: const EdgeInsets.all(3.0),
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: <Widget>[
          Container(color: colors[index]),
          Opacity(
              opacity: _selectIndex == index ? 1 : 0,
              child: Icon(
                Icons.check_circle,
                color: Colors.white,
              ))
        ],
      ),
    );
  }

  void _setLastSelectIndex() async {
    var index = await AccountManager.getInstance().getLastThemeSettingIndex();
    setState(() {
      _selectIndex = index;
    });
  }
}
