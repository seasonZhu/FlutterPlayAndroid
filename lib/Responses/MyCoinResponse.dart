// To parse this JSON data, do
//
//     final myCoinResponse = myCoinResponseFromJson(jsonString);

import 'dart:convert';

MyCoinResponse myCoinResponseFromJson(String str) => MyCoinResponse.fromJson(json.decode(str));

String myCoinResponseToJson(MyCoinResponse data) => json.encode(data.toJson());

class MyCoinResponse {
    MyCoinResponseData data;
    int errorCode;
    String errorMsg;

    MyCoinResponse({
        this.data,
        this.errorCode,
        this.errorMsg,
    });

    factory MyCoinResponse.fromJson(Map<String, dynamic> json) => MyCoinResponse(
        data: MyCoinResponseData.fromJson(json["data"]),
        errorCode: json["errorCode"],
        errorMsg: json["errorMsg"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "errorCode": errorCode,
        "errorMsg": errorMsg,
    };
}

class MyCoinResponseData {
    int curPage;
    List<DataElement> datas;
    int offset;
    bool over;
    int pageCount;
    int size;
    int total;

    MyCoinResponseData({
        this.curPage,
        this.datas,
        this.offset,
        this.over,
        this.pageCount,
        this.size,
        this.total,
    });

    factory MyCoinResponseData.fromJson(Map<String, dynamic> json) => MyCoinResponseData(
        curPage: json["curPage"],
        datas: List<DataElement>.from(json["datas"].map((x) => DataElement.fromJson(x))),
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

class DataElement {
    int coinCount;
    int date;
    String desc;
    int id;
    String reason;
    int type;
    int userId;
    String userName;

    DataElement({
        this.coinCount,
        this.date,
        this.desc,
        this.id,
        this.reason,
        this.type,
        this.userId,
        this.userName,
    });

    factory DataElement.fromJson(Map<String, dynamic> json) => DataElement(
        coinCount: json["coinCount"],
        date: json["date"],
        desc: json["desc"],
        id: json["id"],
        reason: json["reason"],
        type: json["type"],
        userId: json["userId"],
        userName: json["userName"],
    );

    Map<String, dynamic> toJson() => {
        "coinCount": coinCount,
        "date": date,
        "desc": desc,
        "id": id,
        "reason": reason,
        "type": type,
        "userId": userId,
        "userName": userName,
    };
}
