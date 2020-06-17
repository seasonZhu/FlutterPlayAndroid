import 'package:flutter/material.dart';

/// 这个插件其实可有可无,实际上是针对GlobaleKey的使用
class QuickTopFloatButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool defaultVisible;

  QuickTopFloatButton(
      {Key key, @required this.onPressed, this.defaultVisible = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => QuickTopFloatButtonState();
}

class QuickTopFloatButtonState extends State<QuickTopFloatButton> {
  bool _visible = false;

  refreshVisible(bool visible) {
    if (_visible != visible) {
      setState(() {
        _visible = visible;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _visible = widget.defaultVisible;
  }

  @override
  Widget build(BuildContext context) {
    return _visible
        ? Padding(
            child: FloatingActionButton(
                foregroundColor: Colors.white,
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(Icons.keyboard_arrow_up),
                onPressed: widget.onPressed),
            padding: EdgeInsets.all(10.0),
          )
        : SizedBox(
            width: 0.0,
            height: 0.0,
          );
  }
}