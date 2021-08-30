import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:publicart/src/screens/info_screen.dart';
import 'package:publicart/src/utils/colors.dart';

AppBar topBar({
  required BuildContext context,
  required GlobalKey<ScaffoldState> key,
  required String title,
  required bool info,
  required bool backArrow,
  required String filter,
}) =>
    AppBar(
      leading: Builder(builder: (context) {
        if (!backArrow && filter == '') {
          return SizedBox();
        } else if (backArrow) {
          return Padding(
            padding: const EdgeInsets.only(left: 10),
            child: InkWell(
              onTap: () => Get.back(),
              child: SvgPicture.asset('assets/svg/arrow_back.svg'),
            ),
          );
        } else {
          return SizedBox();
        }
      }),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline1!.copyWith(color: white),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: context.width * 0.05),
          child: info
              ? InkWell(
                  onTap: () => Get.to(() => const InfoScreen()),
                  child: SvgPicture.asset('assets/svg/info.svg'),
                )
              : const SizedBox(),
        )
      ],
    );
