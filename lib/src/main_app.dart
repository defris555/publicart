import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart' as gl;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'models/graffity_model.dart';
import 'models/news_model.dart';
import 'screens/gallery.dart';
import 'screens/on_boarding.dart';
import 'utils/theme.dart';

// ignore: use_key_in_widget_constructors, must_be_immutable
class MainApp extends StatelessWidget {
  final GetStorage box = GetStorage();
  late bool first;
  Widget? screen;

  MainApp({Key? key}) : super(key: key);

  _initUserPosition() async {
    try {
      final userPosition = await _getCurrentPosition();
      final lat = userPosition.latitude.toString();
      final lng = userPosition.longitude.toString();
      print('User position ==== $lat, $lng');
      box.write('position', '$lat,$lng');
    } on Exception catch (e) {
      print('GEOLOCKeRRoR');
      print(e.toString());
    }
  }

  Future<LatLng> _getCurrentPosition() async {
    gl.Position position = await _getGeolocation();
    double? lat = position.latitude;
    double? lng = position.longitude;
    final LatLng origin = LatLng(lat, lng);
    return origin;
  }

  //get user current location
  //get user current location
  Future<gl.Position> _getGeolocation() async {
    bool serviceEnabled;
    gl.LocationPermission permission;
    serviceEnabled = await gl.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await gl.Geolocator.checkPermission();
    if (permission == gl.LocationPermission.denied) {
      permission = await gl.Geolocator.requestPermission();
      if (permission == gl.LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == gl.LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await gl.Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Provider.of<GraffityModel>(context, listen: false).getGraffitiesData();
    Provider.of<NewsModel>(context, listen: false).getNewsData();
    _initUserPosition();
    first = box.read('first') ?? true;
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: mainTheme(),
        home: first ? OnBoarding() : Gallery(),
      );
    });
  }
}
