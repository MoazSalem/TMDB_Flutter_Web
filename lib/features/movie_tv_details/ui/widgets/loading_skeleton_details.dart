import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class LoadingSkeletonDetails extends StatelessWidget {
  const LoadingSkeletonDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 70.h > 500 ? 500 : 70.h,
            child: Shimmer(duration: Duration(seconds: 2), child: SizedBox()),
          ),
          const SizedBox(height: 200),
          Center(child: CircularProgressIndicator(color: Color(0xff8fcea2))),
        ],
      ),
    );
  }
}
