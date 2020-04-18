class CoinResponse {
  Data data;
  int errorCode;
  String errorMsg;

  CoinResponse({
    this.data,
    this.errorCode,
    this.errorMsg,
  });

  factory CoinResponse.fromJson(Map<String, dynamic> json) => CoinResponse(
        data: Data.fromJson(json["data"]),
        errorCode: json["errorCode"],
        errorMsg: json["errorMsg"],
  );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "errorCode": errorCode,
        "errorMsg": errorMsg,
  };
}

class Data {
  String coinCount;
  String level;
  String rank;
  String userId;
  String username;

  Data({
    this.coinCount,
    this.level,
    this.rank,
    this.userId,
    this.username,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        coinCount: json["coinCount"]?.toString(),
        level: json["level"]?.toString(),
        rank: json["rank"]?.toString(),
        userId: json["userId"]?.toString(),
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
