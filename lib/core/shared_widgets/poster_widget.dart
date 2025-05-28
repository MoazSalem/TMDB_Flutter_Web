import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tmdb_web/core/helpers/widgets_helper.dart';

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
        alignment: Alignment.topRight,
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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.black54,
              child: CircularPercentIndicator(
                animationDuration: 3000,
                curve: Curves.bounceOut,
                radius: 30.0,
                lineWidth: 5.0,
                percent: (item.voteAverage / 10),
                animation: true,
                center: Text(
                  (item.voteAverage * 10).toStringAsFixed(0),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                progressColor: WidgetsHelper.progressColor(
                  rating: (item.voteAverage * 10),
                ),
                backgroundColor: Colors.white24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
