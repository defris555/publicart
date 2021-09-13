import 'package:flutter/material.dart';

class OvalBottomClip extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    Rect rect =
        Rect.fromLTRB(0.0, 0.0, size.width, size.height - size.height * 0.15);
    return rect;
  }

  @override
  bool shouldReclip(OvalBottomClip oldClipper) {
    return true;
  }
}
