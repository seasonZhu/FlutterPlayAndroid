// To parse this JSON data, do
//
//     final publicNumberResponse = publicNumberResponseFromJson(jsonString);

import 'dart:convert';

PublicNumberResponse publicNumberResponseFromJson(String str) => PublicNumberResponse.fromJson(json.decode(str));

String publicNumberResponseToJson(PublicNumberResponse data) => json.encode(data.toJson());

class PublicNumberResponse {
    List<Datum> data;
    int errorCode;
    String errorMsg;

    PublicNumberResponse({
        this.data,
        this.errorCode,
        this.errorMsg,
    });

    factory PublicNumberResponse.fromJson(Map<String, dynamic> json) => PublicNumberResponse(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        errorCode: json["errorCode"],
        errorMsg: json["errorMsg"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "errorCode": errorCode,
        "errorMsg": errorMsg,
    };
}

class Datum {
    List<dynamic> children;
    int courseId;
    int id;
    String name;
    int order;
    int parentChapterId;
    bool userControlSetTop;
    int visible;

    Datum({
        this.children,
        this.courseId,
        this.id,
        this.name,
        this.order,
        this.parentChapterId,
        this.userControlSetTop,
        this.visible,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        children: List<dynamic>.from(json["children"].map((x) => x)),
        courseId: json["courseId"],
        id: json["id"],
        name: json["name"],
        order: json["order"],
        parentChapterId: json["parentChapterId"],
        userControlSetTop: json["userControlSetTop"],
        visible: json["visible"],
    );

    Map<String, dynamic> toJson() => {
        "children": List<dynamic>.from(children.map((x) => x)),
        "courseId": courseId,
        "id": id,
        "name": name,
        "order": order,
        "parentChapterId": parentChapterId,
        "userControlSetTop": userControlSetTop,
        "visible": visible,
    };
}
