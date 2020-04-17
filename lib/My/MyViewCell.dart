import 'package:flutter/material.dart';

import 'MyListModel.dart';
import 'TargetType.dart';

class MyViewCell extends StatelessWidget {
  final MyListModel _model;

  final ValueChanged<TargetType> _onTapCallback;

  MyViewCell({Key key, @required MyListModel model, ValueChanged<TargetType> onTapCallback})
      : _model = model,
        _onTapCallback = onTapCallback,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(_model.icon),
      title: Text(_model.title),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        _onTapCallback(_model.type);
      }
    );
  }
}