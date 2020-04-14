class TopicInfo {
    List<dynamic> children;
    int courseId;
    int id;
    String name;
    int order;
    int parentChapterId;
    bool userControlSetTop;
    int visible;

    TopicInfo({
        this.children,
        this.courseId,
        this.id,
        this.name,
        this.order,
        this.parentChapterId,
        this.userControlSetTop,
        this.visible,
    });

    factory TopicInfo.fromJson(Map<String, dynamic> json) => TopicInfo(
        children: List<dynamic>.from(json["children"].map((x) => x)),
        courseId: json["courseId"],
        id: json["id"],
        name: (json["name"] as String).replaceAll("&amp;", "&"),
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