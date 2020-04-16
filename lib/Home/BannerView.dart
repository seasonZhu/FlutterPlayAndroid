import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:play_android/HttpUtils/Request.dart';
import 'package:play_android/Responses/BannerResponse.dart';

import 'package:play_android/View/Routes.dart';
import 'package:play_android/Compose/ToastView.dart';

class BannerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getBanner(),
      builder: (BuildContext futureContext, AsyncSnapshot snapshot) {
        //请求完成
        if (snapshot.connectionState == ConnectionState.done) {
          BannerResponse model = snapshot.data;

          //发生错误
          if (snapshot.hasError) {
            ToastView.show(model.errorMsg);
          }
          return bannerView(context, model);
        }
        //请求未完成时弹出loading
        return placeHolderView();
      }
    );
  }

  Future<BannerResponse> getBanner() async {
    var model = await Request.getBanner();
    return model;
  }

  Widget placeHolderView() {
    return Container(height: 200);
  }

  Widget bannerView(BuildContext context, BannerResponse model) {
    return Container(
      height: 200,
      child: Swiper(
          itemBuilder: (BuildContext itemContext, int index) {
            return FadeInImage.assetNetwork(
              placeholder: "assets/images/placeholder.png",
              image: model.data[index].imagePath,
              fit: BoxFit.fill,
            );
          },
          itemCount: model.data.length,
          pagination: SwiperPagination(),
          autoplay: true,
          autoplayDisableOnInteraction: true,
          onTap: (index) {
            _pushToWebView(context, model.data[index]);
          }
        )
      );
  }

  void _pushToWebView(BuildContext context, Datum model) {
    Navigator.pushNamed(context, Routes.informationFlowWebView,
        arguments: model);
  }
}
