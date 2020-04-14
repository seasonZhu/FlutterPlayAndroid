// To parse this JSON data, do
//
//     final articleListResponse = articleListResponseFromJson(jsonString);

import 'dart:convert';
import 'DataInfo.dart';

ArticleListResponse articleListResponseFromJson(String str) => ArticleListResponse.fromJson(json.decode(str));

String articleListResponseToJson(ArticleListResponse data) => json.encode(data.toJson());

class ArticleListResponse {
    List<DataInfo> data;
    int errorCode;
    String errorMsg;

    ArticleListResponse({
        this.data,
        this.errorCode,
        this.errorMsg,
    });

    factory ArticleListResponse.fromJson(Map<String, dynamic> json) => ArticleListResponse(
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
