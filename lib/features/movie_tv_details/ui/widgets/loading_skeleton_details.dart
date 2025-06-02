import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class LoadingSkeletonDetails extends StatelessWidget {
  const LoadingSkeletonDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 70.h > 500 ? 500 : 70.h,
              child: Shimmer(duration: Duration(seconds: 2), child: SizedBox()),
            ),
            SizedBox(height: 10.h),
            Center(child: CircularProgressIndicator(color: Color(0xff8fcea2))),
          ],
        ),
      ),
    );
  }
}
