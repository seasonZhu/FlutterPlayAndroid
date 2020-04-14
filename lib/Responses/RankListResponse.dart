// To parse this JSON data, do
//
//     final rankListResponse = rankListResponseFromJson(jsonString);

import 'dart:convert';

RankListResponse rankListResponseFromJson(String str) => RankListResponse.fromJson(json.decode(str));

String rankListResponseToJson(RankListResponse data) => json.encode(data.toJson());

class RankListResponse {
    RankListResponseData data;
    int errorCode;
    String errorMsg;

    RankListResponse({
        this.data,
        this.errorCode,
        this.errorMsg,
    });

    factory RankListResponse.fromJson(Map<String, dynamic> json) => RankListResponse(
        data: RankListResponseData.fromJson(json["data"]),
        errorCode: json["errorCode"],
        errorMsg: json["errorMsg"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "errorCode": errorCode,
        "errorMsg": errorMsg,
    };
}

class RankListResponseData {
    int curPage;
    List<DataElement> datas;
    int offset;
    bool over;
    int pageCount;
    int size;
    int total;

    RankListResponseData({
        this.curPage,
        this.datas,
        this.offset,
        this.over,
        this.pageCount,
        this.size,
        this.total,
    });

    factory RankListResponseData.fromJson(Map<String, dynamic> json) => RankListResponseData(
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
    int level;
    int rank;
    int userId;
    String username;

    DataElement({
        this.coinCount,
        this.level,
        this.rank,
        this.userId,
        this.username,
    });

    factory DataElement.fromJson(Map<String, dynamic> json) => DataElement(
        coinCount: json["coinCount"],
        level: json["level"],
        rank: json["rank"],
        userId: json["userId"],
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "coinCount": coinCount,
        "level": level,
        "rank": rank,
        "userId": userId,
        "username": username,
    };
}
