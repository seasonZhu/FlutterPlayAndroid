// To parse this JSON data, do
//
//     final myCollectResponse = myCollectResponseFromJson(jsonString);

import 'dart:convert';

import 'InformationFlowProtocol.dart';

MyCollectResponse myCollectResponseFromJson(String str) => MyCollectResponse.fromJson(json.decode(str));

String myCollectResponseToJson(MyCollectResponse data) => json.encode(data.toJson());

class MyCollectResponse {
    MyCollectResponseData data;
    int errorCode;
    String errorMsg;

    MyCollectResponse({
        this.data,
        this.errorCode,
        this.errorMsg,
    });

    factory MyCollectResponse.fromJson(Map<String, dynamic> json) => MyCollectResponse(
        data: MyCollectResponseData.fromJson(json["data"]),
        errorCode: json["errorCode"],
        errorMsg: json["errorMsg"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "errorCode": errorCode,
        "errorMsg": errorMsg,
    };
}

class MyCollectResponseData {
    int curPage;
    List<DataElement> datas;
    int offset;
    bool over;
    int pageCount;
    int size;
    int total;

    MyCollectResponseData({
        this.curPage,
        this.datas,
        this.offset,
        this.over,
        this.pageCount,
        this.size,
        this.total,
    });

    factory MyCollectResponseData.fromJson(Map<String, dynamic> json) => MyCollectResponseData(
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

class DataElement implements InformationFlowProtocol {
    String author;
    int chapterId;
    String chapterName;
    int courseId;
    String desc;
    String envelopePic;
    int id;
    String link;
    String niceDate;
    String origin;
    int originId;
    int publishTime;
    String title;
    int userId;
    int visible;
    int zan;
    bool collect;

    DataElement({
        this.author,
        this.chapterId,
        this.chapterName,
        this.courseId,
        this.desc,
        this.envelopePic,
        this.id,
        this.link,
        this.niceDate,
        this.origin,
        this.originId,
        this.publishTime,
        this.title,
        this.userId,
        this.visible,
        this.zan,
        this.collect
    });

    factory DataElement.fromJson(Map<String, dynamic> json) => DataElement(
        author: json["author"],
        chapterId: json["chapterId"],
        chapterName: json["chapterName"],
        courseId: json["courseId"],
        desc: json["desc"],
        envelopePic: json["envelopePic"],
        id: json["id"],
        link: json["link"],
        niceDate: json["niceDate"],
        origin: json["origin"],
        originId: json["originId"],
        publishTime: json["publishTime"],
        title: json["title"],
        userId: json["userId"],
        visible: json["visible"],
        zan: json["zan"],
        collect: true, // 从这个页面进来的那么一定是收藏的
    );

    Map<String, dynamic> toJson() => {
        "author": author,
        "chapterId": chapterId,
        "chapterName": chapterName,
        "courseId": courseId,
        "desc": desc,
        "envelopePic": envelopePic,
        "id": id,
        "link": link,
        "niceDate": niceDate,
        "origin": origin,
        "originId": originId,
        "publishTime": publishTime,
        "title": title,
        "userId": userId,
        "visible": visible,
        "zan": zan,
    };
}
