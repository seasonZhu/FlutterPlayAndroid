import 'package:flutter/material.dart';

import 'package:play_android/View/Routes.dart';

class MyView extends StatefulWidget {
  @override
  _MyViewState createState() => _MyViewState();
}

class _MyViewState extends State<MyView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.1,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.assessment,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, Routes.rankingView);
            }
          )
        ],
      ),
      body: Center(child: Text("我的"),),
    );
  }
}