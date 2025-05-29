import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_web/core/networking/constants.dart';
import 'package:tmdb_web/core/shared_widgets/rating_widget.dart';

class PosterWidget extends StatelessWidget {
  const PosterWidget({super.key, this.item});
  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => item.title != null
          ? context.go('/movies/${item.id}')
          : context.go('/tv/${item.id}'),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          SizedBox(
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl:
                  "${Constants.imagesBaseUrl}${Constants.posterSizes[3]}${item.posterPath ?? ""}",
              placeholder: (context, url) => const SizedBox(
                height: 600,
                width: 300,
                child: SizedBox(
                  height: 60,
                  width: 60,
                  child: Center(
                    child: CircularProgressIndicator(color: Color(0xff55c3bd)),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => const SizedBox(
                width: 300,
                height: 600,
                child: FittedBox(
                  child: Icon(Icons.question_mark_rounded, size: 300),
                ),
              ),
            ),
          ),
          RatingWidget(item: item),
        ],
      ),
    );
  }
}
