// To parse this JSON data, do
//
//     final ArticleTopListResponse = ArticleTopListResponseFromJson(jsonString);

import 'dart:convert';
import 'DataInfo.dart';

ArticleTopListResponse articleTopListResponseFromJson(String str) => ArticleTopListResponse.fromJson(json.decode(str));

String articleTopListResponseToJson(ArticleTopListResponse data) => json.encode(data.toJson());

class ArticleTopListResponse {
    List<DataInfo> data;
    int errorCode;
    String errorMsg;

    ArticleTopListResponse({
        this.data,
        this.errorCode,
        this.errorMsg,
    });

    factory ArticleTopListResponse.fromJson(Map<String, dynamic> json) => ArticleTopListResponse(
        data: List<DataInfo>.from(json["data"].map((x) => DataInfo.fromJson(x))),
        errorCode: json["errorCode"],
        errorMsg: json["errorMsg"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "errorCode": errorCode,
        "errorMsg": errorMsg,
    };
}
