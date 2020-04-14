import 'package:flutter/material.dart';

import 'package:play_android/Responses/RankListResponse.dart';

class RankingCell extends StatelessWidget {
  final DataElement model;

  RankingCell(this.model);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(model.username),
          subtitle: Text(
            '${model.level}级',
          ),
          trailing: Text("第${model.rank.toString()}名"),
        ),
        Divider()
      ],
    );
  }
}
