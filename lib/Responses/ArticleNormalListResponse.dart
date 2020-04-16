// To parse this JSON data, do
//
//     final articleNormalListResponse = articleNormalListResponseFromJson(jsonString);

import 'dart:convert';

import 'DataInfo.dart';

ArticleNormalListResponse articleNormalListResponseFromJson(String str) => ArticleNormalListResponse.fromJson(json.decode(str));

String articleNormalListResponseToJson(ArticleNormalListResponse data) => json.encode(data.toJson());

class ArticleNormalListResponse {
    ArticleNormalListResponseData data;
    int errorCode;
    String errorMsg;

    ArticleNormalListResponse({
        this.data,
        this.errorCode,
        this.errorMsg,
    });

    factory ArticleNormalListResponse.fromJson(Map<String, dynamic> json) => ArticleNormalListResponse(
        data: ArticleNormalListResponseData.fromJson(json["data"]),
        errorCode: json["errorCode"],
        errorMsg: json["errorMsg"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "errorCode": errorCode,
        "errorMsg": errorMsg,
    };
}

class ArticleNormalListResponseData {
    int curPage;
    List<DataInfo> datas;
    int offset;
    bool over;
    int pageCount;
    int size;
    int total;

    ArticleNormalListResponseData({
        this.curPage,
        this.datas,
        this.offset,
        this.over,
        this.pageCount,
        this.size,
        this.total,
    });

    factory ArticleNormalListResponseData.fromJson(Map<String, dynamic> json) => ArticleNormalListResponseData(
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

