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
    return Stack(
      fit: StackFit.expand,
      children: [
        CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl:
              "${Constants.imagesBaseUrl}${Constants.backdropSizes[2]}/${item.backdropPath ?? item.posterPath ?? ""}",
        ),
        Positioned(top: 8, right: 8, child: RatingWidget(item: item)),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            height: 10.w > 60 ? 60 : 10.w,
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
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 20.0,
            ),
            child: Text(
              '${item.name ?? item.title}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: 3.w > 24 ? 24 : 3.w,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
