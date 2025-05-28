import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_web/core/helpers/widgets_helper.dart';

class PosterWidget extends StatelessWidget {
  const PosterWidget({super.key, this.item});
  final dynamic item;

  @override
  Widget build(BuildContext context) {
    final color = WidgetsHelper.progressColor(rating: (item.voteAverage * 10));
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
                  "https://image.tmdb.org/t/p/w500${item.posterPath ?? ""}",
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
          RatingWidget(item: item, color: color),
        ],
      ),
    );
  }
}

class RatingWidget extends StatelessWidget {
  const RatingWidget({
    super.key,
    required this.item,
    this.color = Colors.white,
  });
  final dynamic item;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        alignment: Alignment.center,
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.black38,
          border: Border.all(color: color, width: 2),
          borderRadius: BorderRadius.circular(200),
        ),
        // backgroundColor: WidgetsHelper.progressColor(
        //   rating: (item.voteAverage * 10),
        // ).withAlpha(100),
        child: Text(
          (item.voteAverage).toStringAsFixed(1),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: color,
          ),
        ),
      ),
    );
  }
}
