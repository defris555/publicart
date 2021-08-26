import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:publicart/src/screens/info_screen.dart';
import 'package:publicart/src/utils/colors.dart';

AppBar topBar(
        BuildContext context, GlobalKey<ScaffoldState> key, String title) =>
    AppBar(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline1!.copyWith(color: white),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: context.width * 0.05),
          child: InkWell(
            onTap: () => Get.to(() => const InfoScreen()),
            child: SvgPicture.asset('assets/svg/info.svg'),
          ),
        )
      ],
    );
