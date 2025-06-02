import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:tmdb_web/core/shared_widgets/skeleton_horizontal_poster_list_widget.dart';
import 'package:tmdb_web/core/shared_widgets/title_widget.dart';

class LoadingSkeletonHome extends StatelessWidget {
  const LoadingSkeletonHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                height: 70.h * Device.aspectRatio > 500
                    ? 500
                    : 70.h * Device.aspectRatio,
                child: CarouselView.weighted(
                  scrollDirection: Axis.horizontal,
                  shrinkExtent: 800,
                  itemSnapping: true,
                  flexWeights: 92.w > 900 ? [3, 2, 1] : [2, 1],
                  children: List<Widget>.generate(
                    3,
                    (index) => Shimmer(
                      duration: Duration(seconds: 2),
                      child: SizedBox(),
                    ),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleWidget(title: "Movies", url: '/movies'),
                SkeletonHorizontalPosterListWidget(),
                TitleWidget(title: "Tv Shows", url: '/tv'),
                SkeletonHorizontalPosterListWidget(),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
