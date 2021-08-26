import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'src/main_app.dart';
import 'src/models/graffity_model.dart';
import 'src/models/news_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GraffityModel()),
        ChangeNotifierProvider(create: (context) => NewsModel()),
      ],
      child: MainApp(),
    ),
  );
}
