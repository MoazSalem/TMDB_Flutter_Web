import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tmdb_web/core/shared_widgets/skeleton_poster_list_widget.dart';

class LoadingSkeletonMovieTvList extends StatelessWidget {
  const LoadingSkeletonMovieTvList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
        child: SkeletonPosterListWidget(),
      ),
    );
  }
}
