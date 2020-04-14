// To parse this JSON data, do
//
//     final publicNumberResponse = publicNumberResponseFromJson(jsonString);

import 'dart:convert';

import 'TopicInfo.dart';

PublicNumberResponse publicNumberResponseFromJson(String str) => PublicNumberResponse.fromJson(json.decode(str));

String publicNumberResponseToJson(PublicNumberResponse data) => json.encode(data.toJson());

// 合并使用InformationFlowListResponse 废弃
class PublicNumberResponse {
    List<TopicInfo> data;
    int errorCode;
    String errorMsg;

    PublicNumberResponse({
        this.data,
        this.errorCode,
        this.errorMsg,
    });

    factory PublicNumberResponse.fromJson(Map<String, dynamic> json) => PublicNumberResponse(
        data: List<TopicInfo>.from(json["data"].map((x) => TopicInfo.fromJson(x))),
        errorCode: json["errorCode"],
        errorMsg: json["errorMsg"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "errorCode": errorCode,
        "errorMsg": errorMsg,
    };
}
