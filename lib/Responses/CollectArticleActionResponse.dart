// To parse this JSON data, do
//
//     final collectArticleActionResponse = collectArticleActionResponseFromJson(jsonString);

import 'dart:convert';

CollectArticleActionResponse collectArticleActionResponseFromJson(String str) => CollectArticleActionResponse.fromJson(json.decode(str));

String collectArticleActionResponseToJson(CollectArticleActionResponse data) => json.encode(data.toJson());

class CollectArticleActionResponse {
    dynamic data;
    int errorCode;
    String errorMsg;

    CollectArticleActionResponse({
        this.data,
        this.errorCode,
        this.errorMsg,
    });

    factory CollectArticleActionResponse.fromJson(Map<String, dynamic> json) => CollectArticleActionResponse(
        data: json["data"],
        errorCode: json["errorCode"],
        errorMsg: json["errorMsg"],
    );

    Map<String, dynamic> toJson() => {
        "data": data,
        "errorCode": errorCode,
        "errorMsg": errorMsg,
    };
}
