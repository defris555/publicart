import 'package:app_settings/app_settings.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location/flutter_map_location.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart' as gl;
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:publicart/src/api/models/graffity_data.dart';
import 'package:publicart/src/screens/info_screen.dart';
import 'package:publicart/src/utils/colors.dart';
import 'package:publicart/src/widgets/bottom_map_bar.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key, required this.allGraffitys}) : super(key: key);

  final List<GraffityData> allGraffitys;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController mapController = MapController();
  LatLng _initialCameraPosition =
      LatLng(59.931604624881714, 30.345241813884833);
  late double ctxH, ctxW;
  bool _loading = false;

  _initPosition() async {
    try {
      _initialCameraPosition = await _getCurrentPosition();
    } on Exception catch (e) {
      print('GEOLOCKeRRoR');
      print(e.toString());
      _initialCameraPosition = LatLng(59.931604624881714, 30.345241813884833);
    }
  }

  @override
  void initState() {
    super.initState();
    _initPosition();
  }

  @override
  Widget build(BuildContext context) {
    final headline = Theme.of(context).textTheme.headline1!;
    final bodytext = Theme.of(context).textTheme.bodyText1!;
    ctxH = context.height;
    ctxW = context.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Карта',
            style: headline.copyWith(color: white),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: ctxW * 0.05),
              child: InkWell(
                onTap: () => Get.to(() => const InfoScreen()),
                child: SvgPicture.asset('assets/svg/info.svg'),
              ),
            )
          ],
        ),
        body: SizedBox(
          width: ctxW,
          height: ctxH,
          child: Stack(
            children: [
              FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  onTap: (_) {
                    //TODO onTap to free Map, if needed
                  },
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
                  // 59.744081,30.286011,59.917671,30.400234
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
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: BottomMapBar(
                  context: context,
                  allGraffities: widget.allGraffitys,
                ),
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
        floatingActionButton: Container(
          width: ctxW * 0.13,
          height: ctxW * 0.13,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(ctxW * 0.01),
            child: SvgPicture.asset(
              'assets/svg/map.svg',
              color: deepCyan,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
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
                          Get.offAll(MapScreen(
                            allGraffitys: widget.allGraffitys,
                          ));
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
                    // Text(
                    //     'Для корректной работы приложения, перейдите в настройки устройства и предоставте приложению доступ к определеню местоположения.'),
                    TextButton(
                      onPressed: () {
                        Get.offAll(
                            MapScreen(allGraffitys: widget.allGraffitys));
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
          padding: EdgeInsets.only(bottom: ctxH * 0.12, right: ctxW * 0.05),
          child: FloatingActionButton(
              heroTag: 'myLocation',
              backgroundColor: white,
              child: SvgPicture.asset(
                'assets/svg/cursor.svg',
                color: deepCyan,
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
      );
    };
  }
}
