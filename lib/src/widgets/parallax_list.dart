import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:publicart/src/api/models/graffity_data.dart';
import 'package:publicart/src/api/sheets/sheets_api.dart';

class ParallaxList extends StatefulWidget {
  const ParallaxList({Key? key}) : super(key: key);

  @override
  State<ParallaxList> createState() => _ParallaxListState();
}

class _ParallaxListState extends State<ParallaxList> {
  List<GraffityData> _allGraffities = [];

  @override
  void initState() {
    super.initState();
    getAllGraffities();
  }

  getAllGraffities() async {
    _allGraffities = [];
    final int count = await SheetsApi.getGraffityRowCount();
    print('Count ====== $count');
    for (int i = 4; i <= count; i++) {
      final GraffityData? graffity = await SheetsApi.getGraffityById(i);
      if (graffity!.id == null) {
        print('_');
      } else {
        print('$i');
        _allGraffities.add(graffity);
      }
    }
    log(_allGraffities.first.address);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [],
      ),
    );
  }
}
