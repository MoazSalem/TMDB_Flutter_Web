import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({super.key, required this.item, required this.ratingSize});
  final dynamic item;
  final double ratingSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star, size: ratingSize, color: Colors.amber),
        const SizedBox(width: 6),
        Text(
          item.voteAverage.toStringAsFixed(1).replaceFirst(RegExp(r'\.?'), ''),
          style: TextStyle(
            color: Colors.white,
            fontSize: ratingSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          item.voteCount > 1000
              ? "/10 (${(item.voteCount / 1000).toStringAsFixed(2)}K)"
              : "/10 (${item.voteCount})",
          style: TextStyle(fontSize: ratingSize, color: Colors.grey.shade400),
        ),
      ],
    );
  }
}
