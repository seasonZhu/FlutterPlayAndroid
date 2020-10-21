import 'package:flutter/material.dart';

import 'package:play_android/Responses/MyCoinResponse.dart';
//import 'package:play_android/Compose/Space.dart';

class MyCoinViewCell extends StatelessWidget {
  final DataElement _model;

  MyCoinViewCell({
    Key key,
    @required DataElement model,
  })  : _model = model,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 66,
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 15),
              child: Text(_model.reason),
            ),
            Expanded(child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(_model.desc, textAlign: TextAlign.start,),
            ),),
            //Space(),
            Container(
              padding: EdgeInsets.only(right: 15),
              child: Text(_model.coinCount.toString()),
            ),
          ],
        ),
      ),
    );
  }
}
