import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tmdb_web/core/helpers/widgets_helper.dart';

class AvatarImageWidget extends StatelessWidget {
  const AvatarImageWidget({
    super.key,
    required this.item,
    this.hd = false,
    required this.type,
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
        ? SizedBox(
            width: 100,
            height: 100,
            child: Icon(Icons.person, size: 36, color: Colors.white),
          )
        : CachedNetworkImage(
            width: 100,
            height: 100,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
            imageUrl: imageUrl,
            placeholder: (context, url) => const SizedBox(
              width: 30,
              height: 60,
              child: Icon(Icons.person, size: 36, color: Colors.white),
            ),
            errorWidget: (context, url, error) => const SizedBox(
              width: 30,
              height: 60,
              child: Icon(Icons.person, size: 36, color: Colors.white),
            ),
          );
  }
}
