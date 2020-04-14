// To parse this JSON data, do
//
//     final hotKeyResponse = hotKeyResponseFromJson(jsonString);

import 'dart:convert';

HotKeyResponse hotKeyResponseFromJson(String str) => HotKeyResponse.fromJson(json.decode(str));

String hotKeyResponseToJson(HotKeyResponse data) => json.encode(data.toJson());

class HotKeyResponse {
    List<Datum> data;
    int errorCode;
    String errorMsg;

    HotKeyResponse({
        this.data,
        this.errorCode,
        this.errorMsg,
    });

    factory HotKeyResponse.fromJson(Map<String, dynamic> json) => HotKeyResponse(
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
    int id;
    String link;
    String name;
    int order;
    int visible;

    Datum({
        this.id,
        this.link,
        this.name,
        this.order,
        this.visible,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        link: json["link"],
        name: json["name"],
        order: json["order"],
        visible: json["visible"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "link": link,
        "name": name,
        "order": order,
        "visible": visible,
    };
}
