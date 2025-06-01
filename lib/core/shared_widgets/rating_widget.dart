import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tmdb_web/core/helpers/widgets_helper.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({
    super.key,
    required this.item,
    this.color = Colors.white,
  });
  final dynamic item;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final color = item.voteAverage == 0.0
        ? Colors.white
        : WidgetsHelper.progressColor(rating: (item.voteAverage * 10));
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        alignment: Alignment.center,
        width: 7.w > 56 ? 56 : 7.w,
        height: 7.w > 56 ? 56 : 7.w,
        decoration: BoxDecoration(
          color: Colors.black38,
          border: Border.all(color: color, width: 2),
          borderRadius: BorderRadius.circular(200),
        ),
        // backgroundColor: WidgetsHelper.progressColor(
        //   rating: (item.voteAverage * 10),
        // ).withAlpha(100),
        child: Text(
          (item.voteAverage).toStringAsFixed(1),
          style: TextStyle(
            fontSize: 15.5.sp > 20 ? 20 : 15.5.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
