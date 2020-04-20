import 'package:flutter/material.dart';

class MyDetailView extends StatefulWidget {
  @override
  _MyDetailViewState createState() => _MyDetailViewState();
}

class _MyDetailViewState extends State<MyDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("个人详情", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.1,
      ),
      body: Container(),
    );
  }
}
