import 'dart:convert';

import 'DataInfo.dart';

InformationFlowListResponse informationFlowListResponseFromJson(String str) => InformationFlowListResponse.fromJson(json.decode(str));

String informationFlowListResponseToJson(InformationFlowListResponse data) => json.encode(data.toJson());

class InformationFlowListResponse {
    List<DataInfo> data;
    int errorCode;
    String errorMsg;

    InformationFlowListResponse({
        this.data,
        this.errorCode,
        this.errorMsg,
    });

    factory InformationFlowListResponse.fromJson(Map<String, dynamic> json) => InformationFlowListResponse(
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