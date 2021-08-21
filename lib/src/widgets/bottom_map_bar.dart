import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:publicart/src/api/models/graffity_data.dart';
import 'package:publicart/src/screens/gallery.dart';
import 'package:publicart/src/screens/info_screen.dart';
import 'package:publicart/src/utils/colors.dart';

class BottomMapBar extends StatefulWidget {
  final BuildContext context;
  const BottomMapBar({Key? key, required this.context}) : super(key: key);

  @override
  _BottomMapBarState createState() => _BottomMapBarState();
}

class _BottomMapBarState extends State<BottomMapBar> {
  @override
  Widget build(BuildContext context) {
    final ctxW = widget.context.width;
    final ctxH = widget.context.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ctxW * 0.05),
      child: Container(
        height: ctxH * 0.075,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: deepCyan,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
            bottomLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(0.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: ctxW * 0.05, top: ctxH * 0.01),
              child: InkWell(
                onTap: () => Get.to(() => Gallery()),
                child: SvgPicture.asset('assets/svg/gallery.svg'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: ctxW * 0.05),
              child: InkWell(
                onTap: () => Get.to(() => const InfoScreen()),
                child: SvgPicture.asset('assets/svg/news.svg'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
