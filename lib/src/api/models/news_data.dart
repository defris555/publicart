import 'package:publicart/src/api/models/news_model.dart';

class NewsData {
  final String? newsId;
  final String title;
  final String longRead;
  final String? newsPhoto;
  final String? date;

  const NewsData({
    this.newsId,
    required this.title,
    required this.longRead,
    this.newsPhoto,
    this.date,
  });

  static NewsData fromJson(Map<String, dynamic> json) => NewsData(
      // newsId: json[NewsModel.newsId],
      title: json[NewsModel.title],
      longRead: json[NewsModel.longRead],
      newsPhoto: json[NewsModel.newsPhoto],
      date: json[NewsModel.date]);

  Map<String, dynamic> toJson() => {
        NewsModel.date: date,
        NewsModel.longRead: longRead,
        NewsModel.newsId: newsId,
        NewsModel.title: title,
      };
}
