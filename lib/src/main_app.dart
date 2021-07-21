import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'screens/home.dart';
import 'utils/theme.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: mainTheme(),
      home: const HomeScreen(),
    );
  }
}
