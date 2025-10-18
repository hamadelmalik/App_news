import 'package:news_app/models/source.dart';
class ArticleData {
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;
  final SourceData source;

  ArticleData({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    required this.source,
  });

  factory ArticleData.formJson(Map<String, dynamic> json) {
    return ArticleData(
      title: json["title"],
      description: json["description"],
      url: json["url"],
      urlToImage: json["urlToImage"],
      publishedAt: json["publishedAt"],
      content: json["content"],
      source: SourceData.formJson(json["source"]),
    );
  }
}