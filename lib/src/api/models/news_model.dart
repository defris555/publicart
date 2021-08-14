class NewsModel {
  static const String newsId = 'newsId';
  static const String title = 'title';
  static const String longRead = 'longRead';
  static const String newsPhoto = 'newsPhoto';
  static const String date = 'date';

  static List<String> getNews() => [newsId, title, longRead, newsPhoto, date];
}
