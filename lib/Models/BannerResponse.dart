// To parse this JSON data, do
//
//     final bannerResponse = bannerResponseFromJson(jsonString);

import 'dart:convert';

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

class Datum {
    String desc;
    int id;
    String imagePath;
    int isVisible;
    int order;
    String title;
    int type;
    String url;

    Datum({
        this.desc,
        this.id,
        this.imagePath,
        this.isVisible,
        this.order,
        this.title,
        this.type,
        this.url,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        desc: json["desc"],
        id: json["id"],
        imagePath: json["imagePath"],
        isVisible: json["isVisible"],
        order: json["order"],
        title: json["title"],
        type: json["type"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "desc": desc,
        "id": id,
        "imagePath": imagePath,
        "isVisible": isVisible,
        "order": order,
        "title": title,
        "type": type,
        "url": url,
    };
}
