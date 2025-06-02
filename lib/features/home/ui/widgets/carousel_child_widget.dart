import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tmdb_web/core/networking/constants.dart';
import 'package:tmdb_web/core/shared_widgets/rating_widget.dart';

class CarouselChildWidget extends StatelessWidget {
  const CarouselChildWidget({super.key, required this.item});
  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          fit: StackFit.expand,
          alignment: Alignment.bottomLeft,
          children: [
            CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl:
                  "${Constants.imagesBaseUrl}${Constants.backdropSizes[2]}/${item.backdropPath ?? item.posterPath ?? ""}",
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(150, 0, 0, 0),
                    Color.fromARGB(0, 0, 0, 0),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            if (constraints.maxWidth >= 30.w)
              Positioned(
                bottom: 20,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${item.name ?? item.title}',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 4.w > 24 ? 24 : 4.w,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    RatingWidget(
                      voteAverage: item.voteAverage,
                      voteCount: item.voteCount,
                      ratingSize: 3.w > 16 ? 16 : 3.w,
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
