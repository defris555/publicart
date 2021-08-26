import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:publicart/src/screens/gallery.dart';
import 'package:publicart/src/screens/map_screen.dart';
import 'package:publicart/src/screens/news_screen.dart';
import 'package:publicart/src/utils/colors.dart';

class BouncingBar extends StatelessWidget {
  const BouncingBar({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      curveSize: 0.0,
      top: -15,
      height: context.height * 0.07,
      backgroundColor: deepCyan,
      initialActiveIndex: index,
      onTap: (int i) {
        if (i == 0) {
          Get.to(() => const Gallery());
        } else if (i == 1) {
          Get.to(() => const MapScreen());
        } else if (i == 2) {
          Get.to(() => const NewsScreen());
        }
      },
      items: [
        TabItem(
          title: 'Список работ',
          icon: SvgPicture.asset('assets/svg/gallery.svg'),
          activeIcon: SvgPicture.asset('assets/svg/galleryActive.svg'),
        ),
        TabItem(
          title: 'Карта',
          icon: SvgPicture.asset('assets/svg/map.svg'),
          activeIcon: SvgPicture.asset('assets/svg/mapActive.svg'),
        ),
        TabItem(
          title: 'Новости',
          icon: SvgPicture.asset('assets/svg/news.svg'),
          activeIcon: SvgPicture.asset('assets/svg/newsActive.svg'),
        ),
        TabItem(
          title: 'Игра',
          icon: SvgPicture.asset('assets/svg/game.svg'),
          activeIcon: SvgPicture.asset('assets/svg/gameActive.svg'),
        ),
      ],
    );
  }
}
