import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:publicart/src/utils/colors.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: context.height,
      color: deepBlue,
      child: Center(),
    );
  }
}
