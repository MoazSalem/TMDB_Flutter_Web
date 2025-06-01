import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tmdb_web/core/helpers/widgets_helper.dart';
import 'package:tmdb_web/features/movie_tv_details/ui/widgets/genres_widget.dart';

class MovieTitleInfoWidget extends StatelessWidget {
  const MovieTitleInfoWidget({super.key, this.item, required this.pageType});
  final dynamic item;
  final String pageType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0.w < 20 ? 20 : 2.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title ?? item.name!,
            style: TextStyle(
              fontSize: 6.w > 30 ? 30 : 6.w,
              fontWeight: FontWeight.bold,
            ),
          ),
          Wrap(
            spacing: 5,
            children: [
              Text(
                "${item.status!}",
                style: TextStyle(
                  color:
                      item.status == "Released" ||
                          item.status == "Returning Series"
                      ? const Color(0xff8fcea2)
                      : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 4.w > 18 ? 18 : 4.w,
                ),
              ),
              if (pageType == "tv")
                Text(
                  "- ${item.numberOfSeasons} Season${item.numberOfSeasons! > 1 ? "s" : ""}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 4.w > 18 ? 18 : 4.w,
                    color: const Color(0xff8fcea2),
                  ),
                ),
              Text(
                "- ${pageType == "tv" ? "${item.numberOfEpisodes} Episode - " : ''}${pageType == "movies"
                    ? "${WidgetsHelper.runtimeToHours(item.runtime!)} -"
                    : item.episodeRunTime! == 0
                    ? ""
                    : "${WidgetsHelper.runtimeToHours(item.episodeRunTime!)} -"} ${pageType == "movies" ? item.releaseDate.split('-')[0] : item.firstAirDate.split('-')[0]}",
                style: TextStyle(
                  fontSize: 4.w > 18 ? 18 : 4.w,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
          if (item.genres!.isNotEmpty)
            GenresWidget(item: item, pageType: pageType),
        ],
      ),
    );
  }
}
