import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_web/core/networking/constants.dart';

class PosterImageWidget extends StatelessWidget {
  const PosterImageWidget({super.key, required this.item});
  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl:
          "${Constants.imagesBaseUrl}${Constants.posterSizes[4]}${item.posterPath ?? ""}",
      placeholder: (context, url) => SizedBox(
        child: Center(
          child: CircularProgressIndicator(color: Color(0xff55c3bd)),
        ),
      ),
      errorWidget: (context, url, error) => const SizedBox(
        child: Center(child: Icon(Icons.question_mark_rounded, size: 100)),
      ),
    );
  }
}
