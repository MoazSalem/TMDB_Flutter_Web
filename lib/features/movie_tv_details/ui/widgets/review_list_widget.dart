import 'package:flutter/material.dart';
import 'package:tmdb_web/core/models/reviews.dart';
import 'package:tmdb_web/core/shared_widgets/title_widget.dart';
import 'review_widget.dart';

class ReviewListWidget extends StatelessWidget {
  const ReviewListWidget({super.key, required this.reviews});
  final List<Review> reviews;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWidget(title: "Reviews"),
        ListView.builder(
          itemCount: reviews.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
            onTap: () {},
            child: ReviewWidget(review: reviews[index]),
          ),
        ),
      ],
    );
  }
}
