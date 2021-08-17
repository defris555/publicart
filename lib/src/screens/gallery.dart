import 'package:flutter/material.dart';
import 'package:publicart/src/api/models/graffity_data.dart';
import 'package:publicart/src/widgets/parallax_list.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key, required this.allGraffities}) : super(key: key);

  final List<GraffityData> allGraffities;

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ParallaxList(
        allGraffities: widget.allGraffities,
      ),
    );
  }
}
