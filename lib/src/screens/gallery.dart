import 'package:flutter/material.dart';
import 'package:publicart/src/widgets/parallax_list.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ParallaxList(),
    );
  }
}
