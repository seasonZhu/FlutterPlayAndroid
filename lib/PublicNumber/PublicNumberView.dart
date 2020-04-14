import 'package:flutter/material.dart';

class PublicNumberView extends StatefulWidget {
  @override
  _PublicNumberViewState createState() => _PublicNumberViewState();
}

class _PublicNumberViewState extends State<PublicNumberView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("公众号", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.1,
      ),
      body: Center(child: Text("公众号")),
    );
  }
}
