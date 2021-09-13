import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/graffity_data.dart';
import '../utils/colors.dart';
import '../widgets/top_bar.dart';

import 'artist_card.dart';

class GraffityCard extends StatefulWidget {
  const GraffityCard({Key? key, required this.artwork}) : super(key: key);

  final GraffityData artwork;

  @override
  _GraffityCardState createState() => _GraffityCardState();
}

class _GraffityCardState extends State<GraffityCard> {
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  final GetStorage box = GetStorage();
  final tooltipController = JustTheController();
  late GraffityData artwork;
  bool _loading = false;

  Future<void> _getRouteOnGooleMaps() async {
    try {
      setState(() {
        _loading = true;
      });
      final String userPosition = await box.read('position');
      final String artworkPosition = artwork.latlng.split(', ').first +
          ',' +
          artwork.latlng.split(', ').last;
      final String routeLink = 'https://www.google.com/maps/dir/' +
          userPosition +
          '/' +
          artworkPosition;
      setState(
        () {
          _loading = false;
          showAnimatedDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return ClassicGeneralDialogWidget(
                titleText: 'Хотите подробнее узнать как добраться?',
                contentText:
                    'Маршрут будет построен в Google картах.\nВы будете преренаправлены на \n"https://www.google.com/maps"',
                negativeText: 'Закрыть',
                positiveText: 'Показать маршрут',
                onPositiveClick: () {
                  Navigator.of(context).pop();
                  // Get.offAll(() => HomeScreen());
                  launch(routeLink);
                },
                onNegativeClick: () {
                  Navigator.of(context).pop();
                },
              );
            },
          );
        },
      );
    } catch (e) {
      setState(() {
        _loading = false;
      });
      print(e.toString());
    }
  }

  void showTooltip() {
    if (tooltipController.isHidden) {
      tooltipController.showTooltip();
    }
  }

  @override
  void initState() {
    super.initState();
    artwork = widget.artwork;
  }

  @override
  Widget build(BuildContext context) {
    final double cHeight = context.height;
    final double cWidth = context.width;
    final TextStyle headline = Theme.of(context).textTheme.headline1!;
    final TextStyle bodytext = Theme.of(context).textTheme.bodyText1!;
    final String artist = artwork.artist;
    return SafeArea(
      child: Scaffold(
        appBar: topBar(
            context: context,
            key: key,
            title: 'Граффити',
            info: false,
            backArrow: true,
            filter: ''),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: cHeight * 0.01),
                    child: Container(
                      width: cWidth,
                      height: cHeight * 0.35,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: Image.network(artwork.photoSqr).image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: cWidth * 0.05, vertical: cHeight * 0.01),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(artwork.name,
                            style: headline.copyWith(color: white)),
                        SizedBox(height: cHeight * 0.01),
                        SizedBox(
                          height: cHeight * 0.08,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  SizedBox(height: cHeight * 0.006),
                                  Text('Автор: ',
                                      style: bodytext.copyWith(color: white)),
                                ],
                              ),
                              Flexible(
                                child: TextButton(
                                  onPressed: () {
                                    if (artist == 'Неизвестен') {
                                      showTooltip();
                                    } else if (artist == 'Инга Утиева') {
                                    } else {
                                      Get.to(() => ArtistCard(artist: artist));
                                    }
                                  },
                                  child: JustTheTooltip(
                                    margin: EdgeInsets.only(
                                        right: cWidth * 0.05,
                                        left: cWidth * 0.3),
                                    backgroundColor: tooltip,
                                    controller: tooltipController,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: cWidth * 0.005),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          artist.toString(),
                                          style: bodytext.copyWith(
                                            color: deepCyan,
                                          ),
                                        ),
                                      ),
                                    ),
                                    content: Padding(
                                      padding: EdgeInsets.all(cWidth * 0.05),
                                      child: RichText(
                                        text: TextSpan(
                                            style: bodytext.copyWith(
                                                color: textGrey),
                                            children: [
                                              TextSpan(
                                                  text:
                                                      'Если Вы знаете кто автор работы, напишите нам на почту '),
                                              TextSpan(
                                                text: 'hey@pushkeen.ru',
                                                style: bodytext.copyWith(
                                                    color: deepCyan),
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: cHeight * 0.06,
                          child: Row(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Адрес: ',
                                  style: bodytext.copyWith(color: white),
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: cWidth * 0.015),
                                      child: Text(
                                        '${artwork.city}, ${artwork.address}',
                                        style: bodytext.copyWith(color: white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          child: TextButton(
                            onPressed: () => _getRouteOnGooleMaps(),
                            child: Text(
                              'Проложить маршрут',
                              style: bodytext.copyWith(color: deepCyan),
                            ),
                          ),
                        ),
                        SizedBox(height: cHeight * 0.035),
                        artwork.description != 'в разработке' &&
                                artwork.description != ''
                            ? Text(artwork.description,
                                style: bodytext.copyWith(color: white))
                            : const SizedBox()
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _loading ? CircularProgressIndicator(color: white) : SizedBox(),
          ],
        ),
      ),
    );
  }
}
