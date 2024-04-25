import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MultipleItemsBanner extends StatelessWidget {
  final List<String> imgList;
  final double aspectRatio;
  const MultipleItemsBanner(
      {super.key, required this.imgList, required this.aspectRatio});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        options: CarouselOptions(
            aspectRatio: aspectRatio,
            enlargeCenterPage: false,
            viewportFraction: 0.90,
            enableInfiniteScroll: true),
        itemCount: (imgList.length / 2).round(),
        itemBuilder: (context, index, realIdx) {
          final int first = index * 1;
          final int second = first + 1;
          final int third = second + 1;
          return Row(
            children: [first, second, third].map((idx) {
              return Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Image.asset(imgList[idx], fit: BoxFit.cover),
                ),
              );
            }).toList(),
          );
        });
  }
}
