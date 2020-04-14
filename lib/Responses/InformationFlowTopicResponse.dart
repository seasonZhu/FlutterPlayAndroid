// To parse this JSON data, do
//
//     final InformationFlowTopicResponse = InformationFlowTopicResponseFromJson(jsonString);

import 'dart:convert';

import 'TopicInfo.dart';

InformationFlowTopicResponse informationFlowTopicResponseFromJson(String str) => InformationFlowTopicResponse.fromJson(json.decode(str));

String informationFlowTopicResponseToJson(InformationFlowTopicResponse data) => json.encode(data.toJson());

class InformationFlowTopicResponse {
    List<TopicInfo> data;
    int errorCode;
    String errorMsg;

    InformationFlowTopicResponse({
        this.data,
        this.errorCode,
        this.errorMsg,
    });

    factory InformationFlowTopicResponse.fromJson(Map<String, dynamic> json) => InformationFlowTopicResponse(
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