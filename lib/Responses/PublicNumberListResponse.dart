// To parse this JSON data, do
//
//     final publicNumberListResponse = publicNumberListResponseFromJson(jsonString);

import 'dart:convert';

import 'DataInfo.dart';

PublicNumberListResponse publicNumberListResponseFromJson(String str) => PublicNumberListResponse.fromJson(json.decode(str));

String publicNumberListResponseToJson(PublicNumberListResponse data) => json.encode(data.toJson());

class PublicNumberListResponse {
    PublicNumberListResponseData data;
    int errorCode;
    String errorMsg;

    PublicNumberListResponse({
        this.data,
        this.errorCode,
        this.errorMsg,
    });

    factory PublicNumberListResponse.fromJson(Map<String, dynamic> json) => PublicNumberListResponse(
        data: PublicNumberListResponseData.fromJson(json["data"]),
        errorCode: json["errorCode"],
        errorMsg: json["errorMsg"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "errorCode": errorCode,
        "errorMsg": errorMsg,
    };
}

class PublicNumberListResponseData {
    int curPage;
    List<DataInfo> datas;
    int offset;
    bool over;
    int pageCount;
    int size;
    int total;

    PublicNumberListResponseData({
        this.curPage,
        this.datas,
        this.offset,
        this.over,
        this.pageCount,
        this.size,
        this.total,
    });

    factory PublicNumberListResponseData.fromJson(Map<String, dynamic> json) => PublicNumberListResponseData(
        curPage: json["curPage"],
        datas: List<DataInfo>.from(json["datas"].map((x) => DataInfo.fromJson(x))),
        offset: json["offset"],
        over: json["over"],
        pageCount: json["pageCount"],
        size: json["size"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "curPage": curPage,
        "datas": List<dynamic>.from(datas.map((x) => x.toJson())),
        "offset": offset,
        "over": over,
        "pageCount": pageCount,
        "size": size,
        "total": total,
    };
}
