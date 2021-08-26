import 'package:publicart/src/models/news_model.dart';

class NewsData {
  final String newsId;
  final String title;
  final String longRead;
  final String newsPhoto;
  final String date;

  const NewsData({
    required this.newsId,
    required this.title,
    required this.longRead,
    required this.newsPhoto,
    required this.date,
  });
}
