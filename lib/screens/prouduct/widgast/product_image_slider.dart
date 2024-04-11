// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vesam_shop/data/modeels/product.dart';
import 'package:vesam_shop/theme.dart';

class ProductImageSlider extends StatefulWidget {
  const ProductImageSlider(this.productDetailModel, {super.key});

  final ProductDetailModel productDetailModel;

  @override
  State<ProductImageSlider> createState() => _ProductImageSliderState();
}

class _ProductImageSliderState extends State<ProductImageSlider> {
  int currenntSliderIndex = 0;

  final CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CarouselSlider(
          carouselController: carouselController,
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              setState(() {
                currenntSliderIndex = index;
              });
            },
            height: 160.0,
            viewportFraction: 1,
            enlargeCenterPage: true,
            autoPlay: true,
          ),
          items: widget.productDetailModel.images!.map((i) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: CachedNetworkImage(
                imageUrl: 'https://flutter.vesam24.com/${i}',
                fit: BoxFit.fill,
                placeholder: (context, url) => const Center(
                  child: CupertinoActivityIndicator(),
                ),
                errorWidget: (context, url, error) => const Center(
                  child: Icon(Icons.error),
                ),
              ),
            );
          }).toList(),
        ),
        Positioned(
            bottom: 12,
            child: AnimatedSmoothIndicator(
              activeIndex: currenntSliderIndex,
              count: widget.productDetailModel.images!.length,
              effect: const ExpandingDotsEffect(
                dotHeight: 6.0,
                dotWidth: 6.0,
                activeDotColor: AppColors.kPrimary500,
                dotColor: AppColors.kGray100,
              ),
            )),
        Positioned(
          right: 6,
          child: CircleAvatar(
            backgroundColor: AppColors.kGray100,
            foregroundColor: AppColors.kGray500,
            child: IconButton(
                onPressed: () {
                  carouselController.nextPage();
                },
                icon: const Icon(Icons.chevron_left_outlined)),
          ),
        ),
        Positioned(
          left: 6,
          child: CircleAvatar(
            backgroundColor: AppColors.kGray100,
            foregroundColor: AppColors.kGray500,
            child: IconButton(
                onPressed: () {
                  carouselController.previousPage();
                },
                icon: const Icon(Icons.chevron_right_outlined)),
          ),
        ),
      ],
    );
  }
}
