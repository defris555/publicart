import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';
import '../widgets/clipper.dart';
import '../widgets/unity_ar.dart';
import '../widgets/bouncing_bar.dart';
import '../widgets/parallax_list.dart';
import '../widgets/top_bar.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: topBar(
          context: context,
          key: key,
          title: 'Граффити',
          info: true,
          backArrow: false,
          filter: '',
        ),
        bottomNavigationBar: BouncingBar(context: context, index: 0),
        body: const ParallaxList(),
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
