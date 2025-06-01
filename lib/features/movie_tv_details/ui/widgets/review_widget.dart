import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tmdb_web/core/models/reviews.dart';
import 'package:tmdb_web/core/networking/constants.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({super.key, required this.review});
  final Review review;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.withAlpha(60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              child: FittedBox(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blueGrey,
                      radius: 30,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CachedNetworkImage(
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          imageUrl: review.authorDetails?.avatarPath != null
                              ? review.authorDetails?.avatarPath!
                                            .split("/")[1]
                                            .split(":")[0] ==
                                        "https"
                                    ? review.authorDetails!.avatarPath!
                                    : "${Constants.imagesBaseUrl}${Constants.profileSizes[1]}${review.authorDetails?.avatarPath}"
                              : "",
                          placeholder: (context, url) => const SizedBox(
                            height: 100,
                            width: 100,
                            child: SizedBox(
                              height: 60,
                              width: 60,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => const SizedBox(
                            width: 30,
                            height: 60,
                            child: Icon(
                              Icons.person,
                              size: 36,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              review.author!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            if (review.authorDetails!.rating != null)
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Card(
                                  color: Colors.black,
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            size: 18,
                                            color: Colors.amber,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            "${review.authorDetails!.rating} / 10",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        Text("Written on ${review.createdAt!.split("T")[0]}"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: ExpandableText(
              review.content!,
              expandText: 'Read More',
              style: TextStyle(fontSize: 4.w > 18 ? 18 : 4.w),
              collapseText: '... Show Less',
              maxLines: 4,
              linkColor: Colors.blueGrey,
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
