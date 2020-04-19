import 'package:flutter/material.dart';

import 'package:play_android/EventBus/EventBus.dart';
import 'package:play_android/ThemeUtils/ThemeUtils.dart';
import 'MyListModel.dart';
import 'package:play_android/Account/AccountManager.dart';

class ThemeSettingView extends StatefulWidget {
  @override
  _ThemeSettingViewState createState() => _ThemeSettingViewState();
}

class _ThemeSettingViewState extends State<ThemeSettingView> {
  
  List<Color> colors = ThemeUtils.supportColors;

  changeColorTheme(Color c) {
    eventBus.fire(ChangeThemeEvent(c));
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
                    AccountManager.getInstance().saveLastThemeSettingIndex(index);
                  },
                  child: Container(
                    color: colors[index],
                    margin: const EdgeInsets.all(3.0),
                  ),
                );
              }),
            )
        )
    );
  }
}