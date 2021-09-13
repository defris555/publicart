import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:provider/src/provider.dart';
import '../models/news_model.dart';
import '../models/news_data.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/colors.dart';

class NewsList extends StatefulWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  List<NewsData> allNews = [];

  @override
  Widget build(BuildContext context) {
    allNews = context.watch<NewsModel>().news;
    return ListView.builder(
      itemBuilder: (context, index) {
        return Column(
          children: [
            for (int i = index; i < allNews.length; i++)
              NewsListItem(
                imgUrl: allNews[i].newsPhoto,
                title: allNews[i].title,
                date: allNews[i].date,
              ),
          ],
        );
      },
      primary: true,
      itemCount: 1,
    );
  }
}

class NewsListItem extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String date;

  NewsListItem({
    Key? key,
    required this.imgUrl,
    required this.title,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctxW = context.width;
    final headline = Theme.of(context)
        .textTheme
        .headline1!
        .copyWith(color: white, fontSize: 17.sp);
    final bodytext = Theme.of(context)
        .textTheme
        .bodyText1!
        .copyWith(color: white, fontSize: 14.sp);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: ctxW * 0.05, left: ctxW * 0.05, right: ctxW * 0.05),
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: ctxW,
                  child: Image.network(imgUrl),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: ctxW * 0.03, bottom: ctxW * 0.01),
                  child: Text(title, style: headline),
                ),
                Text(date, style: bodytext),
              ],
            ),
          ),
        ),
        SizedBox(height: ctxW * 0.02),
        Divider(color: Colors.white.withOpacity(.3)),
      ],
    );
  }
}
