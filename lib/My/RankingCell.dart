import 'package:flutter/material.dart';

import 'package:play_android/Responses/RankListResponse.dart';

class RankingCell extends StatelessWidget {
  final DataElement _model;

  RankingCell({Key key, @required DataElement model})
      : _model = model,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(_model.username),
          subtitle: Text(
            '${_model.level}级',
          ),
          trailing: Text("第${_model.rank.toString()}名"),
        ),
        Divider()
      ],
    );
  }
}
