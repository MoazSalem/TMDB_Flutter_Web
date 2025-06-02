import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:tmdb_web/core/networking/constants.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    required this.item,
    this.isBackdrop = false,
    this.hd = false,
  });
  final dynamic item;
  final bool isBackdrop;
  final bool hd;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl:
          "${Constants.imagesBaseUrl}${isBackdrop ? Constants.backdropSizes[hd ? 3 : 2] : Constants.posterSizes[hd ? 6 : 4]}${isBackdrop ? item.backdropPath ?? item.posterPath ?? "" : item.posterPath ?? ""}",
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          Shimmer(duration: Duration(seconds: 2), child: SizedBox()),
      errorWidget: (context, url, error) => const SizedBox(
        child: Center(child: Icon(Icons.question_mark_rounded, size: 100)),
      ),
    );
  }
}
