import 'dart:convert';

/// Recorta query params que la API agrega después de la extensión de la imagen.
String? cleanNewsImageUrl(String? raw) {
  if (raw == null || raw.trim().isEmpty) return null;
  final value = raw.trim();
  const extensions = ['.jpeg', '.jpg', '.png', '.webp'];
  final lower = value.toLowerCase();
  for (final extension in extensions) {
    final index = lower.indexOf(extension);
    if (index != -1) return value.substring(0, index + extension.length);
  }
  final query = value.indexOf('?');
  return query == -1 ? value : value.substring(0, query);
}

String _asNewsText(dynamic value, {String fallback = ''}) {
  if (value == null) return fallback;
  final text = value.toString().trim();
  return text.isEmpty ? fallback : text;
}

class NewsModel {
  bool? result;
  String? type;
  String? lang;
  int? show;
  List<News>? news;

  NewsModel({
    this.result,
    this.type,
    this.lang,
    this.show,
    this.news,
  });

  factory NewsModel.fromRawJson(String str) => NewsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
      result: json["result"],
      type: json["type"],
      lang: json["lang"],
      show: json["show"] is num ? (json["show"] as num).toInt() : null,
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
    id: _asNewsText(json["id"]),
    title: _asNewsText(json["title"], fallback: 'Sin título'),
    tabTitle: json["tabTitle"]?.toString(),
    date: json["date"] == null ? null : DateTime.tryParse(json["date"].toString()),
    body: _asNewsText(json["body"]),
    adspace: json["adspace"]?.toString(),
    image: json["image"]?.toString(),
    live: json["live"] is bool ? json["live"] as bool : null,
    video: json["video"]?.toString(),
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
