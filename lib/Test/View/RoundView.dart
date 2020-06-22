import 'package:flutter/material.dart';
import 'package:play_android/Compose/Bundle.dart';

class RoundView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("倒圆角的几种方式"),
          centerTitle: true,
        ),
        //  backgroundColor: Colors.grey,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  ClipOval(
                    child:
                        Image.asset(Bundle.imageName("saber", format: "jpg")),
                  ),
                  CircleAvatar(
                    radius: 36.0,
                    backgroundImage: AssetImage(
                      Bundle.imageName("saber", format: "jpg"),
                    ),
                  ),
                  Container(
                    width: 72.0,
                    height: 72.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                          Bundle.imageName("saber", format: "jpg"),
                        ),
                      ),
                    ),
                  ),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: Image.asset(
                          Bundle.imageName("saber", format: "jpg"))),
                  Container(
                    width: 88.0,
                    height: 88.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(6.0),
                      image: DecorationImage(
                        image: AssetImage(
                          Bundle.imageName("saber", format: "jpg"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
