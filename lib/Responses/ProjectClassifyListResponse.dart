// To parse this JSON data, do
//
//     final projectClassifyListResponse = projectClassifyListResponseFromJson(jsonString);

import 'dart:convert';
import 'DataInfo.dart';

ProjectClassifyListResponse projectClassifyListResponseFromJson(String str) => ProjectClassifyListResponse.fromJson(json.decode(str));

String projectClassifyListResponseToJson(ProjectClassifyListResponse data) => json.encode(data.toJson());

class ProjectClassifyListResponse {
    ProjectClassifyListResponseData data;
    int errorCode;
    String errorMsg;

    ProjectClassifyListResponse({
        this.data,
        this.errorCode,
        this.errorMsg,
    });

    factory ProjectClassifyListResponse.fromJson(Map<String, dynamic> json) => ProjectClassifyListResponse(
        data: ProjectClassifyListResponseData.fromJson(json["data"]),
        errorCode: json["errorCode"],
        errorMsg: json["errorMsg"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "errorCode": errorCode,
        "errorMsg": errorMsg,
    };
}

class ProjectClassifyListResponseData {
    int curPage;
    List<DataInfo> datas;
    int offset;
    bool over;
    int pageCount;
    int size;
    int total;

    ProjectClassifyListResponseData({
        this.curPage,
        this.datas,
        this.offset,
        this.over,
        this.pageCount,
        this.size,
        this.total,
    });

    factory ProjectClassifyListResponseData.fromJson(Map<String, dynamic> json) => ProjectClassifyListResponseData(
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