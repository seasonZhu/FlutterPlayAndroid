// To parse this JSON data, do
//
//     final projectClassifyResponse = projectClassifyResponseFromJson(jsonString);

import 'dart:convert';

import 'TopicInfo.dart';

ProjectClassifyResponse projectClassifyResponseFromJson(String str) => ProjectClassifyResponse.fromJson(json.decode(str));

String projectClassifyResponseToJson(ProjectClassifyResponse data) => json.encode(data.toJson());

class ProjectClassifyResponse {
    List<TopicInfo> data;
    int errorCode;
    String errorMsg;

    ProjectClassifyResponse({
        this.data,
        this.errorCode,
        this.errorMsg,
    });

    factory ProjectClassifyResponse.fromJson(Map<String, dynamic> json) => ProjectClassifyResponse(
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