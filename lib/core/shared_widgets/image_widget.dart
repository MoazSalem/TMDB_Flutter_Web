import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tmdb_web/core/helpers/widgets_helper.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    required this.item,
    required this.type,
    this.hd = false,
  });
  final dynamic item;
  final String type;
  final bool hd;

  @override
  Widget build(BuildContext context) {
    final String imageUrl = WidgetsHelper.parseImageUrl(
      item: item,
      type: type,
      hd: hd,
    );
    return imageUrl.isEmpty
        ? const SizedBox(
            child: Center(child: Icon(Icons.question_mark_rounded, size: 100)),
          )
        : CachedNetworkImage(
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
            placeholderFadeInDuration: const Duration(seconds: 2),
            imageUrl: imageUrl,
            placeholder: (context, url) =>
                Container(color: const Color(0xFF212121)),
            errorWidget: (context, url, error) => const SizedBox(
              child: Center(
                child: Icon(Icons.question_mark_rounded, size: 100),
              ),
            ),
          );
  }
}
