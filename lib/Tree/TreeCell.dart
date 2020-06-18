import 'package:flutter/material.dart';

import 'package:lpinyin/lpinyin.dart';

import 'package:play_android/Responses/TopicInfo.dart';

class TreeCell extends StatelessWidget {
  const TreeCell(this.model, {Key key}) : super(key: key);

  final TopicInfo model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: _chipTitleItem(model),
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(width: 0.33, color: Colors.grey[400]))),
      ),
    );
  }

  List<Widget> _chipTitleItem(TopicInfo model) {

    List<Widget> list = [];

    // 从这里看出,final已经非常接近let了
    final text = Text(model.name,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        )
    );

    final space = SizedBox(
      height: 10,
    );

    final wrap = Wrap(
      children: model.children
          .map((topic) => Padding(
              padding: EdgeInsets.all(3.0),
              child: Chip(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                key: ValueKey<String>(topic.name),
                backgroundColor: _getChipBgColor(topic.name),
                label: Text(
                  topic.name,
                  style: TextStyle(fontSize: 14.0),
                ),
              )))
          .toList(),
    );

    list..add(text)..add(space)..add(wrap);
    return list;
  }

  Color _getChipBgColor(String name) {
    String pinyin = PinyinHelper.getFirstWordPinyin(name);
    pinyin = pinyin.substring(0, 1).toUpperCase();
    return _nameToColor(pinyin);
  }

  Color _nameToColor(String name) {
    final int hash = name.hashCode & 0xffff;
    final double hue = (360.0 * hash / (1 << 15)) % 360.0;
    return HSVColor.fromAHSV(1.0, hue, 0.4, 0.90).toColor();
  }
}
