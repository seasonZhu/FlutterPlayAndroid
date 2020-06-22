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

                  // 使用ClipOval切圆角的时候,最好不要加宽高限制,会导致图片倒角没有到理想的境界
                  Container(
                      width: 88.0,
                      height: 88.0,
                      child: ClipOval(
                        child: Image.asset(
                            Bundle.imageName("saber", format: "jpg")),
                      )),
                  SizedBox(height: 10,),

                  // 完美
                  CircleAvatar(
                    radius: 44.0,
                    backgroundImage: AssetImage(
                      Bundle.imageName("saber", format: "jpg"),
                    ),
                  ),
                  SizedBox(height: 10,),

                  // Container的装饰器倒角,也不一定能倒出完美的圆角
                  Container(
                    width: 88.0,
                    height: 88.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      //borderRadius: BorderRadius.circular(44.0),
                      image: DecorationImage(
                        image: AssetImage(
                          Bundle.imageName("saber", format: "jpg"),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),

                  // ClipRRect倒部分角 可行
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child:
                          Image.asset(Bundle.imageName("saber", format: "jpg")),
                    ),
                    width: 88,
                    height: 88,
                  ),
                  SizedBox(height: 10,),

                  // 装饰器倒部分角 可行
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
        ));
  }
}
