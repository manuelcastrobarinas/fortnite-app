import 'dart:convert';

class ShopModel {
  bool? result;
  String? type;
  String? lang;
  int? show;
  List<News>? news;

  ShopModel({
    this.result,
    this.type,
    this.lang,
    this.show,
    this.news,
  });

  factory ShopModel.fromRawJson(String str) => ShopModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShopModel.fromJson(Map<String, dynamic> json) => ShopModel(
      result: json["result"],
      type: json["type"],
      lang: json["lang"],
      show: json["show"],
      news: json["news"] == null ? [] : List<News>.from(json["news"]!.map((x) => News.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
      "result": result,
      "type": type,
      "lang": lang,
      "show": show,
      "news": news == null ? [] : List<dynamic>.from(news!.map((x) => x.toJson())),
  };
}

class News {
  String id;
  String title;
  String? tabTitle;
  DateTime? date;
  String body;
  String? adspace;
  String? image;
  bool? live;
  String? video;

  News({
    required this.id,
    required this.title,
    this.tabTitle,
    this.date,
    required this.body,
    this.adspace,
    this.image,
    this.live,
    this.video,
  });

  factory News.fromRawJson(String str) => News.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory News.fromJson(Map<String, dynamic> json) => News(
    id: json["id"],
    title: json["title"],
    tabTitle: json["tabTitle"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    body: json["body"],
    adspace: json["adspace"],
    image: json["image"],
    live: json["live"],
    video: json["video"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "tabTitle": tabTitle,
    "date": date?.toIso8601String(),
    "body": body,
    "adspace": adspace,
    "image": image,
    "live": live,
    "video": video,
  };
}
