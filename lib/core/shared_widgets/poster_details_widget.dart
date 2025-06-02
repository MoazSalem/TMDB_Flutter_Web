import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tmdb_web/core/shared_widgets/rating_widget.dart';

class PosterDetailsWidget extends StatelessWidget {
  const PosterDetailsWidget({super.key, required this.item});
  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${item.title ?? item.name}",
            style: TextStyle(
              fontSize: 10.sp < 18 ? 18 : 10.sp,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          RatingWidget(
            voteAverage: item.voteAverage,
            voteCount: item.voteCount,
            ratingSize: 4.w > 16 ? 16 : 4.w,
          ),
        ],
      ),
    );
  }
}
