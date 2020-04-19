// To parse this JSON data, do
//
//     final accountInfoResponse = accountInfoResponseFromJson(jsonString);

import 'dart:convert';

AccountInfoResponse accountInfoResponseFromJson(String str) => AccountInfoResponse.fromJson(json.decode(str));

String accountInfoResponseToJson(AccountInfoResponse data) => json.encode(data.toJson());

// 注意 登录与注册使用同一个响应模型
class AccountInfoResponse {
    AccountInfo data;
    int errorCode;
    String errorMsg;

    AccountInfoResponse({
        this.data,
        this.errorCode,
        this.errorMsg,
    });

    factory AccountInfoResponse.fromJson(Map<String, dynamic> json) => AccountInfoResponse(
        data: AccountInfo.fromJson(json["data"]),
        errorCode: json["errorCode"],
        errorMsg: json["errorMsg"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "errorCode": errorCode,
        "errorMsg": errorMsg,
    };
}

class AccountInfo {
    bool admin;
    List<int> chapterTops;
    List<int> collectIds;
    String email;
    String icon;
    int id;
    String nickname;
    String password;
    String publicName;
    String token;
    int type;
    String username;

    AccountInfo({
        this.admin,
        this.chapterTops,
        this.collectIds,
        this.email,
        this.icon,
        this.id,
        this.nickname,
        this.password,
        this.publicName,
        this.token,
        this.type,
        this.username,
    });

    factory AccountInfo.fromJson(Map<String, dynamic> json) => AccountInfo(
        admin: json["admin"],
        chapterTops: List<int>.from(json["chapterTops"].map((x) => x)),
        collectIds: List<int>.from(json["collectIds"].map((x) => x)),
        email: json["email"],
        icon: json["icon"],
        id: json["id"],
        nickname: json["nickname"],
        password: json["password"],
        publicName: json["publicName"],
        token: json["token"],
        type: json["type"],
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "admin": admin,
        "chapterTops": List<int>.from(chapterTops.map((x) => x)),
        "collectIds": List<int>.from(collectIds.map((x) => x)),
        "email": email,
        "icon": icon,
        "id": id,
        "nickname": nickname,
        "password": password,
        "publicName": publicName,
        "token": token,
        "type": type,
        "username": username,
    };
}
