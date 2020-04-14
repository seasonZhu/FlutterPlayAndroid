import 'dart:convert';

import 'DataInfo.dart';

InformationFlowListResponse informationFlowListResponseFromJson(String str) => InformationFlowListResponse.fromJson(json.decode(str));

String informationFlowListResponseToJson(InformationFlowListResponse data) => json.encode(data.toJson());

class InformationFlowListResponse {
    InformationFlowListResponseData data;
    int errorCode;
    String errorMsg;

    InformationFlowListResponse({
        this.data,
        this.errorCode,
        this.errorMsg,
    });

    factory InformationFlowListResponse.fromJson(Map<String, dynamic> json) => InformationFlowListResponse(
        data: InformationFlowListResponseData.fromJson(json["data"]),
        errorCode: json["errorCode"],
        errorMsg: json["errorMsg"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "errorCode": errorCode,
        "errorMsg": errorMsg,
    };
}

class InformationFlowListResponseData {
    int curPage;
    List<DataInfo> datas;
    int offset;
    bool over;
    int pageCount;
    int size;
    int total;

    InformationFlowListResponseData({
        this.curPage,
        this.datas,
        this.offset,
        this.over,
        this.pageCount,
        this.size,
        this.total,
    });

    factory InformationFlowListResponseData.fromJson(Map<String, dynamic> json) => InformationFlowListResponseData(
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