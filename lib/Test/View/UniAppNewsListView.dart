import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:play_android/Compose/LoadingView.dart';

/// 新闻列表页
class UniAppNewsListView extends StatefulWidget {
  UniAppNewsListView({Key key}) : super(key: key);

  @override
  _UniAppNewsListViewState createState() => _UniAppNewsListViewState();
}

class _UniAppNewsListViewState extends State<UniAppNewsListView> {
  List<News> news = [];

  @override
  void initState() {
    super.initState();
    _getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("uni-app的一个例子编写"),
        ),
        body: _body());
  }

  Widget _body() {
    return news.length > 0
        ? SafeArea(
            child: ListView.separated(
              itemCount: news.length,
              itemBuilder: (context, index) => cell(model: news[index]),
              separatorBuilder: (context, index) => Divider(),
            ),
          )
        : LoadingView();
  }

  Widget cell({News model}) {
    return GestureDetector(
      child: UniAppNewsListCell(
        model: model,
      ),
      onTap: () {
        print("点击${model.id}");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UniAppNewsDetailView(
              model: model,
            ),
          ),
        );
      },
    );
  }

  void _getNews() async {
    Response response =
        await Dio().get("https://unidemo.dcloud.net.cn/api/news");
    List maps = response.data;

    /// dynamic => 数组字典 => 数组模型
    List<News> list = maps
        .map((map) => map as Map<String, dynamic>)
        .toList()
        .map((json) => News.fromJson(json))
        .toList();
    setState(() {
      news = list;
    });
  }
}

/// cell
class UniAppNewsListCell extends StatelessWidget {
  const UniAppNewsListCell({Key key, this.model}) : super(key: key);

  final News model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 66,
            height: 66,
            child: CachedNetworkImage(
              imageUrl: model.authorAvatar,
              placeholder: (context, url) => Image.asset(
                "assets/images/placeholder.png",
              ),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  model.title,
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Spacer(),
                    Text("发布时间: " + model.createdAt,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        )),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 新闻详细页面
class UniAppNewsDetailView extends StatelessWidget {
  const UniAppNewsDetailView({Key key, this.model}) : super(key: key);

  final News model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(model.title),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Html(
            padding: const EdgeInsets.all(10),
            data: model.content,
          ),
        ),
      ),
    );
  }
}

/// 模型
class News {
  News({
    this.id,
    this.fromId,
    this.title,
    this.summary,
    this.columnId,
    this.columnName,
    this.authorName,
    this.authorEmail,
    this.authorAvatar,
    this.postId,
    this.cover,
    this.content,
    this.viewsCount,
    this.commentsCount,
    this.publishedAt,
    this.storeAt,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String fromId;
  String title;
  String summary;
  String columnId;
  String columnName;
  String authorName;
  String authorEmail;
  String authorAvatar;
  String postId;
  String cover;
  String content;
  int viewsCount;
  int commentsCount;
  String publishedAt;
  String storeAt;
  String type;
  String createdAt;
  String updatedAt;

  factory News.fromJson(Map<String, dynamic> json) => News(
        id: json["id"],
        fromId: json["from_id"],
        title: json["title"],
        summary: json["summary"],
        columnId: json["column_id"],
        columnName: json["column_name"],
        authorName: json["author_name"],
        authorEmail: json["author_email"],
        authorAvatar: json["author_avatar"],
        postId: json["post_id"],
        cover: json["cover"],
        content: json["content"],
        viewsCount: json["views_count"],
        commentsCount: json["comments_count"],
        publishedAt: json["published_at"],
        storeAt: json["store_at"],
        type: json["type"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "from_id": fromId,
        "title": title,
        "summary": summary,
        "column_id": columnId,
        "column_name": columnName,
        "author_name": authorName,
        "author_email": authorEmail,
        "author_avatar": authorAvatar,
        "post_id": postId,
        "cover": cover,
        "content": content,
        "views_count": viewsCount,
        "comments_count": commentsCount,
        "published_at": publishedAt,
        "store_at": storeAt,
        "type": type,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
