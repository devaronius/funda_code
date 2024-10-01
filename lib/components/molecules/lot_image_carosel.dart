import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class LotImageCarousel extends StatelessWidget {
  final List<String> images;

  const LotImageCarousel(this.images);

  @override
  Widget build(BuildContext context) {
    return SliverPinnedHeader(
      child: Container(
        height: 200,
        child: CarouselSlider.builder(
          itemCount: images.length,
          itemBuilder: (context, index, realIndex) {
            return CachedNetworkImage(
              width: double.infinity,
              imageUrl: images[index],
              fit: BoxFit.fitHeight,
              placeholder: (context, url) => const CircularProgressIndicator(),
            );
          },
          options: CarouselOptions(),
        ),
      ),
    );
  }
}
