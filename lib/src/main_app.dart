import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'screens/map_screen.dart';
import 'screens/on_boarding.dart';
import 'utils/theme.dart';

// ignore: use_key_in_widget_constructors, must_be_immutable
class MainApp extends StatelessWidget {
  final GetStorage box = GetStorage();
  late bool first;
  Widget? screen;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    first = box.read('first') ?? true;
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: mainTheme(),
        home: first ? const OnBoarding() : const MapScreen(),
      );
    });
  }
}
