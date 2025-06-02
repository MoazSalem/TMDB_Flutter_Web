import 'package:flutter/material.dart';
import 'package:tmdb_web/core/helpers/widgets_helper.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({
    super.key,
    required this.ratingSize,
    required this.voteAverage,
    required this.voteCount,
  });
  final num voteAverage;
  final num voteCount;
  final double ratingSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star, size: ratingSize, color: Colors.amber),
        const SizedBox(width: 6),
        Text(
          WidgetsHelper.parseRating(rating: voteAverage),
          style: TextStyle(
            color: Colors.white,
            fontSize: ratingSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          WidgetsHelper.parseVoteCount(count: voteCount),
          style: TextStyle(fontSize: ratingSize, color: Colors.grey.shade400),
        ),
      ],
    );
  }
}
