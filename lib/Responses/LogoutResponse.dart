// To parse this JSON data, do
//
//     final logoutResponse = logoutResponseFromJson(jsonString);

import 'dart:convert';

LogoutResponse logoutResponseFromJson(String str) => LogoutResponse.fromJson(json.decode(str));

String logoutResponseToJson(LogoutResponse data) => json.encode(data.toJson());

class LogoutResponse {
    dynamic data;
    int errorCode;
    String errorMsg;

    LogoutResponse({
        this.data,
        this.errorCode,
        this.errorMsg,
    });

    factory LogoutResponse.fromJson(Map<String, dynamic> json) => LogoutResponse(
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
