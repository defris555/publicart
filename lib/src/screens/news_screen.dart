import 'package:flutter/material.dart';
import 'package:publicart/src/widgets/bouncing_bar.dart';
import 'package:publicart/src/widgets/news_list.dart';
import 'package:publicart/src/widgets/top_bar.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: topBar(
          context: context,
          key: key,
          title: 'Новости',
          info: true,
          backArrow: false,
          filter: '',
        ),
        bottomNavigationBar: const BouncingBar(index: 2),
        body: const NewsList(),
      ),
    );
  }
}
