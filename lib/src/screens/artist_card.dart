import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/graffity_data.dart';
import '../models/graffity_model.dart';
import '../widgets/top_bar.dart';

class ArtistCard extends StatefulWidget {
  const ArtistCard({Key? key, required this.artist}) : super(key: key);

  final String artist;

  @override
  _ArtistCardState createState() => _ArtistCardState();
}

class _ArtistCardState extends State<ArtistCard> {
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  List<GraffityData> dataCollection = [];
  List<String> artworks = [];
  GraffityData? data;
  late String artist;

  _getArtistArtworks() {
    artworks = [];
    dataCollection.forEach((item) {
      if (item.artist == artist) {
        data = item;
        artworks.add(item.photoSqr);
      }
    });
    print('Колличество работ ====== ${artworks.length}');
  }

  @override
  void initState() {
    super.initState();
    artist = widget.artist;
  }

  @override
  Widget build(BuildContext context) {
    dataCollection = context.watch<GraffityModel>().artworks;
    _getArtistArtworks();
    final double cHeight = context.height;
    final double cWidth = context.width;
    final TextStyle headline = Theme.of(context).textTheme.headline1!;
    final TextStyle bodytext = Theme.of(context).textTheme.bodyText1!;
    final String artist = data!.artist;
    final String avatar = data!.avatar;
    final String insta = data!.insta;
    final String insta2 = data!.insta2;
    return SafeArea(
      child: Scaffold(
          appBar: topBar(
              context: context,
              key: key,
              title: 'Автор',
              info: false,
              backArrow: true,
              filter: ''),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: cHeight * 0.01),
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Container(
                      width: cWidth,
                      // height: cHeight * 0.35,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: Image.network(avatar).image,
                          fit: BoxFit.cover,
                        ),
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
                      Text(
                        artist,
                        style: headline.copyWith(color: white),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: cHeight * 0.01),
                      InkWell(
                        onTap: () {},
                        child: SizedBox(
                          height: cHeight * 0.031,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: cWidth * 0.02),
                                child: SvgPicture.asset('assets/svg/insta.svg'),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  '@$insta',
                                  style: bodytext.copyWith(color: white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      insta2.length > 2
                          ? InkWell(
                              onTap: () {},
                              child: SizedBox(
                                height: cHeight * 0.031,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(right: cWidth * 0.02),
                                      child: SvgPicture.asset(
                                          'assets/svg/insta.svg'),
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Text(
                                        '@$insta2',
                                        style: bodytext.copyWith(color: white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
