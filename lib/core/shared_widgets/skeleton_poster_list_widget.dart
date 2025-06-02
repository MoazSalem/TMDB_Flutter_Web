import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:tmdb_web/core/helpers/widgets_helper.dart';

class SkeletonPosterListWidget extends StatelessWidget {
  const SkeletonPosterListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      cacheExtent: 3500,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 2.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.6685,
        mainAxisSpacing: 1,
        crossAxisCount: WidgetsHelper.crossAxisCount(currentWidth: 100.w),
      ),
      itemCount: 10,
      itemBuilder: (BuildContext context, index) {
        return Shimmer(duration: Duration(seconds: 2), child: SizedBox());
      },
    );
  }
}
