import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tmdb_web/core/models/reviews.dart';

Widget reviewWidget({required Review review}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Card(
      color: Colors.grey.withOpacity(0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 20.0,
              bottom: 5.0,
            ),
            child: SizedBox(
              child: FittedBox(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color(0xff0d9bc6),
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
                                    : "https://image.tmdb.org/t/p/w200${review.authorDetails?.avatarPath}"
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
                            child: Icon(Icons.person, size: 36),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 60.w,
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            review.author!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Written on ${review.createdAt!.split("T")[0]}",
                            ),
                            review.authorDetails!.rating == null
                                ? Container()
                                : Padding(
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
                                                color: Color(0xff8fcea2),
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                "${review.authorDetails!.rating}",
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
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: ExpandableText(
              review.content!,
              expandText: 'Read More',
              style: TextStyle(fontSize: 4.w > 18 ? 18 : 4.w),
              collapseText: '... Show Less',
              maxLines: 3,
              linkColor: const Color(0xff8fcea2),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    ),
  );
}
