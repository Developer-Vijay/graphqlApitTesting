// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

NewsModel newsModelFromJson(String str) =>
    NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
  NewsModel({
    required this.typename,
    required this.news,
  });

  final String typename;
  final List<News> news;

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        typename: json["__typename"],
        news: List<News>.from(
            json["News"].map((x) => News.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename,
        "News": List<dynamic>.from(news.map((x) => x.toJson())),
      };
}

class News {
  News({
    required this.typename,
    required this.title,
    required this.url,
    required this.publishedAt,
    required this.author,
    required this.content,
    required this.description,
    required this.hId,
    required this.source,
    required this.urlToImage,
  });

  final String typename;
  final String title;
  final String url;
  final DateTime publishedAt;
  final String author;
  final String content;
  final String description;
  final int hId;
  final String source;
  final String urlToImage;

  factory News.fromJson(Map<String, dynamic> json) => News(
        typename: json["__typename"],
        title: json["title"],
        url: json["url"].toString(),
        publishedAt: DateTime.parse(json["publishedAt"]),
        author: json["author"],
        content: json["content"],
        description: json["description"],
        hId: json["h_id"],
        source: json["source"],
        urlToImage: json["urlToImage"],
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename,
        "title": title,
        "url": url,
        "publishedAt":
            "${publishedAt.year.toString().padLeft(4, '0')}-${publishedAt.month.toString().padLeft(2, '0')}-${publishedAt.day.toString().padLeft(2, '0')}",
        "author": author,
        "content": content,
        "description": description,
        "h_id": hId,
        "source": source,
        "urlToImage": urlToImage,
      };
}
