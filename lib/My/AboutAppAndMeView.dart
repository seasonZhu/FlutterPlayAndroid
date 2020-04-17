import 'package:flutter/material.dart';

import 'MyListModel.dart';

class AboutAppAndMeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyListModel model = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(model.title, style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.1,
      ),
      body: Container(),
    );
  }
}