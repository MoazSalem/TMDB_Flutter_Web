import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:tmdb_web/core/shared_widgets/poster_details_widget.dart';
import 'package:tmdb_web/core/shared_widgets/image_widget.dart';

class SkeletonHorizontalPosterListWidget extends StatelessWidget {
  const SkeletonHorizontalPosterListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 330,
      child: CarouselView(
        itemExtent: 220,
        shrinkExtent: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        scrollDirection: Axis.horizontal,
        children: List<Widget>.generate(
          8,
          (index) => Shimmer(duration: Duration(seconds: 2), child: SizedBox()),
        ),
      ),
    );
  }
}
