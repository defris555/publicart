import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../widgets/unity_ar.dart';

import '../screens/projects_screen.dart';
import '../screens/gallery.dart';
import '../screens/map_screen.dart';
import '../screens/news_screen.dart';
import '../utils/colors.dart';

class BouncingBar extends StatelessWidget {
  const BouncingBar({Key? key, required this.index, required this.context})
      : super(key: key);
  final int index;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      curveSize: 0.0,
      top: -0.1,
      height: context.height * 0.07,
      activeColor: back,
      elevation: 0,
      backgroundColor: back,
      initialActiveIndex: index,
      onTap: (int i) {
        if (i == 0) {
          Get.to(() => const Gallery());
        } else if (i == 1) {
          Get.to(() => const MapScreen());
        } else if (i == 2) {
          // Get.to(() => UnityWidgetSceneRouter(context: context));
        } else if (i == 3) {
          Get.to(() => const NewsScreen());
        } else if (i == 4) {
          Get.to(() => const ProjectsScreen());
        }
      },
      items: [
        TabItem(
          title: 'Галерея',
          icon: SvgPicture.asset('assets/svg/gallery.svg'),
          activeIcon: SvgPicture.asset(
            'assets/svg/gallery.svg',
            color: cyan,
          ),
        ),
        TabItem(
          title: 'Карта',
          icon: SvgPicture.asset('assets/svg/map.svg'),
          activeIcon: SvgPicture.asset(
            'assets/svg/map.svg',
            color: cyan,
          ),
        ),
        TabItem(title: 'AR', icon: SizedBox()),
        TabItem(
          title: 'Новости',
          icon: SvgPicture.asset('assets/svg/news.svg'),
          activeIcon: SvgPicture.asset(
            'assets/svg/news.svg',
            color: cyan,
          ),
        ),
        TabItem(
          title: 'Проекты',
          icon: SvgPicture.asset('assets/svg/game.svg'),
          activeIcon: SvgPicture.asset(
            'assets/svg/game.svg',
            color: cyan,
          ),
        ),
      ],
      color: Colors.white,
    );
  }
}
