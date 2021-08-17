import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:publicart/src/api/sheets/sheets_api.dart';

import 'src/api/models/graffity_data.dart';
import 'src/main_app.dart';
import 'src/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List<GraffityData> allGraffities = [];
  getAllGraffities() async {
    final int count = await SheetsApi.getGraffityRowCount();
    print('Count ====== $count');
    for (int i = 4; i <= count; i++) {
      final GraffityData? graffity = await SheetsApi.getGraffityById(i);
      if (graffity!.id == null) {
        print('_');
      } else {
        print('$i');
        allGraffities.add(graffity);
      }
    }
    log('$photoUrlPrefix/${allGraffities.first.photoUrl}');
  }

  await SheetsApi.init();
  await GetStorage.init();
  await getAllGraffities();
  runApp(MainApp(
    allGraffities: allGraffities,
  ));
}
