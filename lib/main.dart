import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:publicart/src/api/sheets/sheets_api.dart';

import 'src/main_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SheetsApi.init();
  await GetStorage.init();
  runApp(MainApp());
}
