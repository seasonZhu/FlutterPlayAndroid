import 'Tag.dart';
import 'InformationFlowProtocol.dart';

class DataInfo implements InformationFlowProtocol {
    String apkLink;
    int audit;
    String author;
    bool canEdit;
    int chapterId;
    String chapterName;
    bool collect;
    int courseId;
    String desc;
    String descMd;
    String envelopePic;
    bool fresh;
    int id;
    String link;
    String niceDate;
    String niceShareDate;
    String origin;
    String prefix;
    String projectLink;
    int publishTime;
    int selfVisible;
    int shareDate;
    String shareUser;
    int superChapterId;
    String superChapterName;
    List<Tag> tags;
    String title;
    int type;
    int userId;
    int visible;
    int zan;

    DataInfo({
        this.apkLink,
        this.audit,
        this.author,
        this.canEdit,
        this.chapterId,
        this.chapterName,
        this.collect,
        this.courseId,
        this.desc,
        this.descMd,
        this.envelopePic,
        this.fresh,
        this.id,
        this.link,
        this.niceDate,
        this.niceShareDate,
        this.origin,
        this.prefix,
        this.projectLink,
        this.publishTime,
        this.selfVisible,
        this.shareDate,
        this.shareUser,
        this.superChapterId,
        this.superChapterName,
        this.tags,
        this.title,
        this.type,
        this.userId,
        this.visible,
        this.zan,
    });

    factory DataInfo.fromJson(Map<String, dynamic> json) => DataInfo(
        apkLink: json["apkLink"],
        audit: json["audit"],
        author: json["author"],
        canEdit: json["canEdit"],
        chapterId: json["chapterId"],
        chapterName: json["chapterName"],
        collect: json["collect"],
        courseId: json["courseId"],
        desc: json["desc"],
        descMd: json["descMd"],
        envelopePic: json["envelopePic"],
        fresh: json["fresh"],
        id: json["id"],
        link: json["link"],
        niceDate: json["niceDate"],
        niceShareDate: json["niceShareDate"],
        origin: json["origin"],
        prefix: json["prefix"],
        projectLink: json["projectLink"],
        publishTime: json["publishTime"],
        selfVisible: json["selfVisible"],
        shareDate: json["shareDate"],
        shareUser: json["shareUser"],
        superChapterId: json["superChapterId"],
        superChapterName: json["superChapterName"],
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
        title: json["title"],
        type: json["type"],
        userId: json["userId"],
        visible: json["visible"],
        zan: json["zan"],
    );

    Map<String, dynamic> toJson() => {
        "apkLink": apkLink,
        "audit": audit,
        "author": author,
        "canEdit": canEdit,
        "chapterId": chapterId,
        "chapterName": chapterName,
        "collect": collect,
        "courseId": courseId,
        "desc": desc,
        "descMd": descMd,
        "envelopePic": envelopePic,
        "fresh": fresh,
        "id": id,
        "link": link,
        "niceDate": niceDate,
        "niceShareDate": niceShareDate,
        "origin": origin,
        "prefix": prefix,
        "projectLink": projectLink,
        "publishTime": publishTime,
        "selfVisible": selfVisible,
        "shareDate": shareDate,
        "shareUser": shareUser,
        "superChapterId": superChapterId,
        "superChapterName": superChapterName,
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
        "title": title,
        "type": type,
        "userId": userId,
        "visible": visible,
        "zan": zan,
    };
}

