import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tezda_app/widgets/place_holder_image.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({super.key, required this.imageUrls});

  final List<String> imageUrls;

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final CarouselSliderController sliderController = CarouselSliderController();
  late final List<String> imageUrls = widget.imageUrls;

  @override
  void dispose() {
    sliderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220.h,
      child: CarouselSlider.builder(
        controller: sliderController,
        autoSliderDelay: const Duration(milliseconds: 7500),
        unlimitedMode: imageUrls.length > 1,
        itemCount: imageUrls.length,
        slideBuilder: (i) {
          return CachedNetworkImage(
            imageUrl: imageUrls[i],
            fit: BoxFit.contain,
            errorWidget: (context, url, error) =>
                const PlaceHolderImage(isTransparent: true),
            placeholder: (context, url) =>
                const PlaceHolderImage(isTransparent: true),
          );
        },
        slideIndicator: imageUrls.length > 1
            ? CircularSlideIndicator(indicatorRadius: 4.r, itemSpacing: 10)
            : null,
        slideTransform: const ZoomOutSlideTransform(),
        enableAutoSlider: imageUrls.length > 1,
      ),
    );
  }
}
