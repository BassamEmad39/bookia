import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/features/home/data/model/slider_response/slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({super.key, required this.sliders});
  final List<SliderModel> sliders;
  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.sliders.isEmpty
            ? emptyUi()
            : CarouselSlider.builder(
              itemCount: widget.sliders.length,
              itemBuilder: (
                BuildContext context,
                int itemIndex,
                int pageViewIndex,
              ) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: widget.sliders[itemIndex].image ?? '',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                );
              },
              options: CarouselOptions(
                height: 150,
                viewportFraction: 0.9,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  setState(() {
                    activeIndex = index;
                  });
                },
              ),
            ),
        Gap(15),
        SmoothPageIndicator(
          controller: PageController(
            initialPage: activeIndex,
          ), // PageController
          count: widget.sliders.length,
          effect: ExpandingDotsEffect(
            activeDotColor: AppColors.primaryColor,
            dotColor: AppColors.borderColor,
            dotHeight: 8,
            dotWidth: 8,
            spacing: 4,
            expansionFactor: 5,
          ), // your preferred effect
          onDotClicked: (index) {},
        ),
      ],
    );
  }

  emptyUi() {
    return SizedBox(
      width: double.infinity,
      height: 150,
      child: Shimmer.fromColors(
        baseColor: AppColors.accentColor,
        highlightColor: AppColors.primaryColor,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
