import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tmdb_web/core/networking/constants.dart';
import 'package:tmdb_web/core/shared_widgets/rating_widget.dart';

class SmallPosterWidget extends StatelessWidget {
  const SmallPosterWidget({super.key, this.item});
  final dynamic item;

  @override
  Widget build(BuildContext context) {
    final double ratingSize = 4.w > 16 ? 16 : 4.w;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                height: 400,
                width: 280,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl:
                      "${Constants.imagesBaseUrl}${Constants.posterSizes[3]}${item.posterPath ?? ""}",
                  placeholder: (context, url) => const SizedBox(
                    height: 260,
                    width: 160,
                    child: SizedBox(
                      height: 60,
                      width: 60,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color(0xff55c3bd),
                        ),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => const SizedBox(
                    width: 60,
                    height: 100,
                    child: Icon(Icons.question_mark_rounded, size: 100),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 170,
                width: 220,
                alignment: Alignment.bottomLeft,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(140, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: constraints.maxWidth >= 160
                    ? Padding(
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
                              ratingSize: ratingSize,
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ),
            ),
          ],
        );
      },
    );
  }
}
