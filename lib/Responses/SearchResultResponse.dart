// To parse this JSON data, do
//
//     final searchResultResponse = searchResultResponseFromJson(jsonString);

import 'dart:convert';

import 'DataInfo.dart';

SearchResultResponse searchResultResponseFromJson(String str) => SearchResultResponse.fromJson(json.decode(str));

String searchResultResponseToJson(SearchResultResponse data) => json.encode(data.toJson());

class SearchResultResponse {
    SearchResultResponseData data;
    int errorCode;
    String errorMsg;

    SearchResultResponse({
        this.data,
        this.errorCode,
        this.errorMsg,
    });

    factory SearchResultResponse.fromJson(Map<String, dynamic> json) => SearchResultResponse(
        data: SearchResultResponseData.fromJson(json["data"]),
        errorCode: json["errorCode"],
        errorMsg: json["errorMsg"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "errorCode": errorCode,
        "errorMsg": errorMsg,
    };
}

class SearchResultResponseData {
    int curPage;
    List<DataInfo> datas;
    int offset;
    bool over;
    int pageCount;
    int size;
    int total;

    SearchResultResponseData({
        this.curPage,
        this.datas,
        this.offset,
        this.over,
        this.pageCount,
        this.size,
        this.total,
    });

    factory SearchResultResponseData.fromJson(Map<String, dynamic> json) => SearchResultResponseData(
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
