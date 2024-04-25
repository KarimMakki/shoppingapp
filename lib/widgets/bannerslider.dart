import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class BannerSlider extends StatelessWidget {
  final List<Widget> imglist;
  final double indicatorBottomPadding;

  const BannerSlider(
      {super.key, required this.imglist, required this.indicatorBottomPadding});

  @override
  Widget build(BuildContext context) {
    return ImageSlideshow(
        height: MediaQuery.of(context).size.height * 0.185,
        indicatorRadius: 5,
        indicatorBottomPadding: indicatorBottomPadding,
        indicatorPadding: 6,
        isLoop: true,
        indicatorColor: Colors.white,
        autoPlayInterval: 2000,
        children: imglist);
  }
}
