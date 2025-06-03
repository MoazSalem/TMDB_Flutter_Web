import 'package:flutter/material.dart';
import 'package:tmdb_web/core/shared_widgets/rating_widget.dart';

class PosterDetailsWidget extends StatelessWidget {
  const PosterDetailsWidget({
    super.key,
    required this.item,
    required this.titleSize,
    required this.ratingSize,
  });
  final dynamic item;
  final double titleSize;
  final double ratingSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            "${item.title ?? item.name}",
            style: TextStyle(fontSize: titleSize, fontWeight: FontWeight.w600),
            maxLines: 4,
            overflow: TextOverflow.fade,
            softWrap: false,
          ),
        ),
        RatingWidget(
          voteAverage: item.voteAverage,
          voteCount: item.voteCount,
          ratingSize: ratingSize,
        ),
      ],
    );
  }
}
