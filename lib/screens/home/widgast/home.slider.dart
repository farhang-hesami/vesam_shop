import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vesam_shop/data/modeels/home.dart';
import 'package:vesam_shop/theme.dart';

class HomeSlider extends StatefulWidget {
  

final HomeModel homeModel;
 const HomeSlider(this.homeModel, {super.key});

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {

int currenntSliderIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CarouselSlider(
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
          items: widget.homeModel.slides!.map((i) {
            
              
                return  ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: CachedNetworkImage(
                  imageUrl: 'https://flutter.vesam24.com/${i.image}',
                  fit: BoxFit.fill,
                  placeholder: (context, url) => const Center(child: CupertinoActivityIndicator(),),
                  errorWidget: (context, url, error) => const Center(child: Icon(Icons.error),),
                  ),
                  
                );
                
          }).toList(),
        ),
        Positioned(
          bottom: 12,
          child: AnimatedSmoothIndicator(
            activeIndex: currenntSliderIndex, 
            count: widget.homeModel.slides!.length,
              effect:const ExpandingDotsEffect(
                dotHeight: 6.0,
                dotWidth: 6.0,
                activeDotColor: AppColors.kPrimary500,
                dotColor: AppColors.kGray100,

              ),
            )),
      ],
      
    );
  }
}
