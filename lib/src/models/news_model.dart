import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/news_data.dart';

class NewsModel extends ChangeNotifier {
  List<NewsData> _news = [];
  List<NewsData> get news => _news;

  getNewsData() async {
    var snapshot = await FirebaseFirestore.instance.collection('news').get();
    _news = [];
    var data = snapshot.docs;
    _news.addAll(data.map((event) {
      return NewsData(
        newsId: event['id'],
        title: event['title'],
        longRead: event['longread'],
        newsPhoto: event['photo'],
        date: event['date'],
      );
    }).toList());
    _news.sort((a, b) => int.parse(b.newsId).compareTo(int.parse(a.newsId)));
    notifyListeners();
  }
}
