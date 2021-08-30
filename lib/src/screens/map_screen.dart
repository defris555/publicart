import 'package:app_settings/app_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location/flutter_map_location.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart' as gl;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:latlong2/latlong.dart';
import 'package:publicart/src/models/graffity_data.dart';
import 'package:publicart/src/utils/colors.dart';
import 'package:publicart/src/widgets/bouncing_bar.dart';
import 'package:publicart/src/widgets/top_bar.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final GetStorage box = GetStorage();
  final MapController mapController = MapController();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  LatLng _initialCameraPosition =
      LatLng(59.931604624881714, 30.345241813884833);
  late double ctxH, ctxW;
  bool _loading = false;
  bool _isMarked = false;
  List<Marker> markers = [];
  List<GraffityData> allGraffities = [];
  final _firestore = FirebaseFirestore.instance;

  _initPosition() async {
    if (!await box.hasData('position')) {
      try {
        _initialCameraPosition = await _getCurrentPosition();
      } catch (e) {
        print('GEOLOCKeRRoR');
        print(e.toString());
        _initialCameraPosition = LatLng(59.931604624881714, 30.345241813884833);
      }
    } else {
      try {
        String position = await box.read('position');
        double lat = double.parse(position.split(',').first);
        double lng = double.parse(position.split(',').last);
        LatLng userPosition = LatLng(lat, lng);
        _initialCameraPosition = userPosition;
      } catch (e) {
        print(e.toString());
        _initialCameraPosition = LatLng(59.931604624881714, 30.345241813884833);
      }
    }
  }

  _getMarkers() async {
    setState(() {
      _isMarked = false;
    });
    var snapshot = await _firestore.collection('graffities').get();
    markers = [];
    var data = snapshot.docs;
    markers.addAll(data.map((item) {
      String lat = item['latlng'].split(', ').first;
      String lng = item['latlng'].split(', ').last;
      LatLng point = LatLng(double.parse(lat), double.parse(lng));
      return Marker(
          key: ValueKey(item.id),
          width: ctxW * 0.15,
          height: ctxH * 0.15,
          point: point,
          builder: (context) {
            return _artMarker(item['photoSqr']);
          });
    }));
    setState(() {
      _isMarked = true;
      print(markers.first.point.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    _initPosition();
    _getMarkers();
  }

  @override
  Widget build(BuildContext context) {
    // final headline = Theme.of(context).textTheme.headline1!;
    // final bodytext = Theme.of(context).textTheme.bodyText1!;
    // _getMarkers();
    ctxH = context.height;
    ctxW = context.width;
    return SafeArea(
      child: Scaffold(
        appBar: topBar(
          context: context,
          key: key,
          title: 'Карта',
          info: true,
          backArrow: false,
          filter: '',
        ),
        bottomNavigationBar: const BouncingBar(index: 1),
        body: SizedBox(
          width: ctxW,
          height: ctxH,
          child: Stack(
            children: [
              FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  minZoom: 11.5,
                  maxZoom: 17.41,
                  zoom: 13.5,
                  interactiveFlags:
                      InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                  plugins: [
                    MarkerClusterPlugin(),
                    LocationPlugin(),
                  ],
                  center: _initialCameraPosition,
                ),
                nonRotatedLayers: [
                  LocationOptions(
                    locationButton(),
                    onLocationUpdate: (LatLngData? ld) async {},
                    onLocationRequested: (LatLngData? ld) {
                      if (ld == null) {
                        return;
                      }
                    },
                    markerBuilder: (BuildContext context, LatLngData ld,
                        ValueNotifier<double?> heading) {
                      return Marker(
                        point: ld.location,
                        builder: (_) => SvgPicture.asset('assets/svg/you.svg'),
                      );
                    },
                  ),
                ],
                layers: [
                  TileLayerOptions(
                    // tileProvider: AssetTileProvider(),
                    //
                    additionalOptions: {
                      'accessToken':
                          'pk.eyJ1IjoicHVzaGtlZW4yMDIxIiwiYSI6ImNrcW1kNTIycjAwa3Uydm8yYnJqM2toZmIifQ.Ykf_LHKFdlL3OPRWE2glqw',
                      'id': 'mapbox.mapbox-streets-v8'
                    },
                    minZoom: 11.11,
                    maxZoom: 17.51,
                    // urlTemplate: 'assets/tiles/{z}/{x}/{y}.png',
                    urlTemplate:
                        'https://api.mapbox.com/styles/v1/pushkeen2021/ckqtmhja300ra18qpbwmi98o2/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoicHVzaGtlZW4yMDIxIiwiYSI6ImNrcW1kNTIycjAwa3Uydm8yYnJqM2toZmIifQ.Ykf_LHKFdlL3OPRWE2glqw',
                  ),
                  MarkerLayerOptions(
                    markers: _isMarked ? markers : [],
                  ),
                ],
              ),
              _loading
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: white,
                    ))
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _artMarker(String imgUrl) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          // width: ctxW * 0.2,
          // height: ctxW * 0.2,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: EdgeInsets.all(ctxW * 0.01),
            child: Image.network(imgUrl),
          ),
        ),
        SvgPicture.asset(
          'assets/svg/tail.svg',
          height: ctxH * 0.015,
        ),
      ],
    );
  }

  Future<LatLng> _getCurrentPosition() async {
    gl.Position position = await _getGeolocation();
    double? lat = position.latitude;
    double? lng = position.longitude;
    final LatLng origin = LatLng(lat, lng);
    return origin;
  }

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
        setState(
          () {
            _loading = false;
            showAnimatedDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return SimpleDialog(
                    title: Text(
                      'Приложению требуется доступ к вашему местоположению!',
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(color: deepCyan),
                    ),
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.offAll(MapScreen());
                          setState(() {
                            AppSettings.openLocationSettings();
                          });
                        },
                        child: Text('Перейти к настройкам',
                            style: Theme.of(context).textTheme.bodyText1),
                      )
                    ]);
              },
            );
          },
        );
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == gl.LocationPermission.deniedForever) {
      setState(
        () {
          _loading = false;
          showAnimatedDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return SimpleDialog(
                  title: Text(
                    'Приложению требуется доступ к вашему местоположению!',
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(color: deepCyan),
                  ),
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.offAll(MapScreen());
                        setState(() {
                          AppSettings.openLocationSettings();
                        });
                      },
                      child: Text('Перейти к настройкам',
                          style: Theme.of(context).textTheme.bodyText1),
                    )
                  ]);
            },
          );
        },
      );
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await gl.Geolocator.getCurrentPosition();
  }

  LocationButtonBuilder locationButton() {
    return (BuildContext context, ValueNotifier<LocationServiceStatus> status,
        Function onPressed) {
      return Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: EdgeInsets.only(bottom: ctxH * 0.03, right: ctxW * 0.05),
          child: Container(
            decoration: BoxDecoration(
              color: deepCyan,
              borderRadius: BorderRadius.circular(8),
            ),
            child: FloatingActionButton(
                heroTag: 'myLocation',
                elevation: 0,
                backgroundColor: deepCyan,
                child: SvgPicture.asset(
                  'assets/svg/cursor.svg',
                  color: white,
                ),
                onPressed: () async {
                  setState(() {
                    _loading = true;
                  });
                  var position = await _getCurrentPosition();

                  setState(() {
                    _loading = false;
                    try {
                      mapController.move(position, 12.0);
                    } catch (e) {
                      print(e.toString());
                    }
                  });
                }),
          ),
        ),
      );
    };
  }
}
