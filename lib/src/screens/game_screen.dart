import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../widgets/unity_ar.dart';
import '../widgets/bouncing_bar.dart';
import '../widgets/top_bar.dart';
import '../utils/colors.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late double cWidth;
  late double cHeight;

  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    cHeight = context.height;
    cWidth = context.width;
    return SafeArea(
      child: Scaffold(
        appBar: topBar(
          context: context,
          key: key,
          title: 'Проекты',
          info: false,
          backArrow: false,
          filter: '',
        ),
        bottomNavigationBar: BouncingBar(context: context, index: 4),
        body: Padding(
          padding: EdgeInsets.only(
              top: cWidth * 0.05, left: cWidth * 0.05, right: cWidth * 0.05),
          child: Column(
            children: [
              SizedBox(
                width: cWidth,
                child: Image.asset('assets/images/game.png'),
              ),
              _gameButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _gameButtons() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: cWidth * 0.425,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: deepCyan,
              ),
              child: TextButton(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: cWidth * 0.03, vertical: cHeight * 0.015),
                  child: Text(
                    'Игра на время',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: white, fontSize: 16.5.sp),
                    textAlign: TextAlign.center,
                  ),
                ),
                onPressed: () {
                  // Get.to(() =>
                  //     UnityWidgetSceneRouter(context: context, scene: 'game1'));
                },
              ),
            ),
            Container(
              width: cWidth * 0.425,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: deepCyan,
              ),
              child: TextButton(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: cWidth * 0.03, vertical: cHeight * 0.015),
                  child: Text(
                    '2 игрока',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: white, fontSize: 16.5.sp),
                    textAlign: TextAlign.center,
                  ),
                ),
                onPressed: () {
                  // Get.to(() =>
                  //     UnityWidgetSceneRouter(context: context, scene: 'game2'));
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
