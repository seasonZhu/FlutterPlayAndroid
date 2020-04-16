// To parse this JSON data, do
//
//     final bannerResponse = bannerResponseFromJson(jsonString);

import 'dart:convert';

import 'InformationFlowProtocol.dart';

BannerResponse bannerResponseFromJson(String str) => BannerResponse.fromJson(json.decode(str));

String bannerResponseToJson(BannerResponse data) => json.encode(data.toJson());

class BannerResponse {
    List<Datum> data;
    int errorCode;
    String errorMsg;

    BannerResponse({
        this.data,
        this.errorCode,
        this.errorMsg,
    });

    factory BannerResponse.fromJson(Map<String, dynamic> json) => BannerResponse(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        errorCode: json["errorCode"],
        errorMsg: json["errorMsg"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "errorCode": errorCode,
        "errorMsg": errorMsg,
    };
}

class Datum implements InformationFlowProtocol {
    String desc;
    int id;
    String imagePath;
    int isVisible;
    int order;
    String title;
    int type;
    String link;
    bool collect;

    Datum({
        this.desc,
        this.id,
        this.imagePath,
        this.isVisible,
        this.order,
        this.title,
        this.type,
        this.link,
        this.collect
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        desc: json["desc"],
        id: json["id"],
        imagePath: json["imagePath"],
        isVisible: json["isVisible"],
        order: json["order"],
        title: json["title"],
        type: json["type"],
        link: json["url"],
        collect: false
    );

    Map<String, dynamic> toJson() => {
        "desc": desc,
        "id": id,
        "imagePath": imagePath,
        "isVisible": isVisible,
        "order": order,
        "title": title,
        "type": type,
        "url": link,
    };
}
