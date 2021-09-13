import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';
import '../widgets/unity_ar.dart';
import '../widgets/bouncing_bar.dart';
import '../widgets/news_list.dart';
import '../widgets/top_bar.dart';

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
        bottomNavigationBar: BouncingBar(context: context, index: 3),
        body: const NewsList(),
        floatingActionButton: InkWell(
          onTap: () {
            // Get.to(() => UnityWidgetSceneRouter(context: context));
          },
          child: Padding(
            padding: EdgeInsets.only(top: context.height * 0.025),
            child: ClipOval(
              clipper: OvalBottomClip(),
              child: Container(
                width: context.width * 0.175,
                height: context.width * 0.15,
                color: back,
                child: Center(
                  child: SvgPicture.asset(
                    'assets/svg/ar.svg',
                  ),
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

class OvalBottomClip extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    Rect rect =
        Rect.fromLTRB(0.0, 0.0, size.width, size.height - size.height * 0.15);
    return rect;
  }

  @override
  bool shouldReclip(OvalBottomClip oldClipper) {
    return true;
  }
}
