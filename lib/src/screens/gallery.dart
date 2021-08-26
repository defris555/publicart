import 'package:flutter/material.dart';
import 'package:publicart/src/widgets/bouncing_bar.dart';
import 'package:publicart/src/widgets/parallax_list.dart';
import 'package:publicart/src/widgets/top_bar.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: topBar(context, key, 'Граффити'),
        bottomNavigationBar: const BouncingBar(index: 0),
        body: const ParallaxList(),
      ),
    );
  }
}
