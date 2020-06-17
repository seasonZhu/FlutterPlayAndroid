import 'dart:convert';

TreeResponse treeResponseFromJson(String str) => TreeResponse.fromJson(json.decode(str));

String treeResponseToJson(TreeResponse data) => json.encode(data.toJson());

class TreeResponse {
    TreeResponse({
        this.data,
        this.errorCode,
        this.errorMsg,
    });

    List<Datum> data;
    int errorCode;
    String errorMsg;

    factory TreeResponse.fromJson(Map<String, dynamic> json) => TreeResponse(
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

    List<Datum> children;
    int courseId;
    int id;
    String name;
    int order;
    int parentChapterId;
    bool userControlSetTop;
    int visible;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        children: List<Datum>.from(json["children"].map((x) => Datum.fromJson(x))),
        courseId: json["courseId"],
        id: json["id"],
        name: json["name"],
        order: json["order"],
        parentChapterId: json["parentChapterId"],
        userControlSetTop: json["userControlSetTop"],
        visible: json["visible"],
    );

    Map<String, dynamic> toJson() => {
        "children": List<dynamic>.from(children.map((x) => x.toJson())),
        "courseId": courseId,
        "id": id,
        "name": name,
        "order": order,
        "parentChapterId": parentChapterId,
        "userControlSetTop": userControlSetTop,
        "visible": visible,
    };
}
