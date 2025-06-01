import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MovieRatingWidget extends StatelessWidget {
  const MovieRatingWidget({super.key, this.item});
  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star, size: 4.w > 18 ? 18 : 4.w, color: Colors.amber),
        const SizedBox(width: 6),
        Text(
          item.voteAverage.toStringAsFixed(1).replaceFirst(RegExp(r'\.?'), ''),
          style: TextStyle(
            color: Colors.white,
            fontSize: 4.w > 18 ? 18 : 4.w,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          item.voteCount > 1000
              ? "/10 (${(item.voteCount / 1000).toStringAsFixed(2)}K)"
              : "/10 (${item.voteCount})",
          style: TextStyle(
            fontSize: 4.w > 18 ? 18 : 4.w,
            color: Colors.grey.shade400,
          ),
        ),
      ],
    );
  }
}
