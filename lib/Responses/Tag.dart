class Tag {
    String name;
    String url;

    Tag({
        this.name,
        this.url,
    });

    factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
    };
}