import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tmdb_web/core/helpers/widgets_helper.dart';
import 'package:tmdb_web/core/networking/constants.dart';
import 'package:tmdb_web/features/movie_tv_details/logic/movie_tv_details_cubit.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:tmdb_web/core/shared_widgets/small_poster_widget.dart';
import 'package:tmdb_web/core/shared_widgets/actor_widget.dart';
import 'package:tmdb_web/features/movie_tv_details/ui/widgets/categories_widget.dart';
import 'package:tmdb_web/core/shared_widgets/review_widget.dart';

// This page is opened when you press on a item
class MovieTvDetails extends StatefulWidget {
  const MovieTvDetails({super.key, required this.pageType});
  final String pageType;

  @override
  State<MovieTvDetails> createState() => _MovieTvDetailsState();
}

class _MovieTvDetailsState extends State<MovieTvDetails> {
  final Color grey = Colors.grey.shade400;
  bool videoPressed = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MediaQuery.sizeOf(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieTvDetailsCubit, MovieTvDetailsState>(
      builder: (context, state) {
        return Scaffold(
          body: state is MovieTvDetailsLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Color(0xff8fcea2)),
                )
              : state is MovieTvDetailsLoaded
              ? ListView(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: state.item.posterPath != ""
                          ? Image.network(
                              fit: BoxFit.cover,
                              "${Constants.imagesBaseUrl}${Constants.backdropSizes[3]}${state.item.backdropPath ?? state.item.posterPath}",
                              errorBuilder: (context, error, stackTrace) {
                                return const SizedBox(
                                  width: 300,
                                  height: 600,
                                  child: FittedBox(
                                    child: Icon(
                                      Icons.question_mark_rounded,
                                      size: 300,
                                    ),
                                  ),
                                );
                              },
                            )
                          : Container(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10.0,
                                top: 20,
                              ),
                              child: Text(
                                state.item.title ?? state.item.name!,
                                style: TextStyle(
                                  fontSize: 6.w > 30 ? 30 : 6.w,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    state.item.status!,
                                    style: TextStyle(
                                      color:
                                          state.item.status == "Released" ||
                                              state.item.status ==
                                                  "Returning Series"
                                          ? const Color(0xff8fcea2)
                                          : Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 4.w > 18 ? 18 : 4.w,
                                    ),
                                  ),
                                  widget.pageType != "movies"
                                      ? Row(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 5.0,
                                              ),
                                              child: Text("-"),
                                            ),
                                            Text(
                                              "${state.item.numberOfSeasons} Season${state.item.numberOfSeasons! > 1 ? "s" : ""}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 4.w > 18 ? 18 : 4.w,
                                                color: const Color(0xff8fcea2),
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 5.0,
                                              ),
                                              child: Text("-"),
                                            ),
                                            Text(
                                              "${state.item.numberOfEpisodes} Episodes",
                                              style: TextStyle(
                                                fontSize: 4.w > 18 ? 18 : 4.w,
                                                color: grey,
                                              ),
                                            ),
                                            if (state.item.episodeRunTime != 0)
                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 5.0,
                                                ),
                                                child: Text("-"),
                                              ),
                                            if (state.item.episodeRunTime != 0)
                                              Text(
                                                WidgetsHelper.runtimeToHours(
                                                  state.item.episodeRunTime!,
                                                ),
                                                style: TextStyle(
                                                  fontSize: 4.w > 18 ? 18 : 4.w,
                                                  color: grey,
                                                ),
                                              ),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 5.0,
                                              ),
                                              child: Text("-"),
                                            ),
                                            Text(
                                              WidgetsHelper.runtimeToHours(
                                                state.item.runtime ?? 0,
                                              ),
                                              style: TextStyle(
                                                fontSize: 4.w > 18 ? 18 : 4.w,
                                                color: grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 5.0,
                                    ),
                                    child: Text("-"),
                                  ),
                                  Text(
                                    widget.pageType == "movies"
                                        ? state.item.releaseDate.split('-')[0]
                                        : state.item.firstAirDate.split('-')[0],
                                    style: TextStyle(
                                      fontSize: 4.w > 18 ? 18 : 4.w,
                                      color: grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            state.item.genres!.isNotEmpty
                                ? SizedBox(
                                    width:
                                        90.w > 120 * state.item.genres!.length
                                        ? (120 * state.item.genres!.length)
                                              .toDouble()
                                        : 90.w,
                                    child: FittedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8.0,
                                          horizontal: 5,
                                        ),
                                        child: SizedBox(
                                          height: 44,
                                          child: ListView.builder(
                                            itemCount:
                                                state.item.genres!.length,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder:
                                                (
                                                  BuildContext context,
                                                  int index,
                                                ) => CategoriesWidget(
                                                  index: index,
                                                  item: state.item,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                state.item.overview,
                                style: TextStyle(
                                  fontSize: 4.w > 18
                                      ? 100.w > 1200
                                            ? 22
                                            : 18
                                      : 4.w,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 4.w > 18 ? 18 : 4.w,
                                    color: const Color(0xff8fcea2),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    state.item.voteAverage
                                        .toStringAsFixed(1)
                                        .replaceFirst(RegExp(r'\.?'), ''),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 4.w > 18 ? 18 : 4.w,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    state.item.voteCount > 1000
                                        ? "/10 (${(state.item.voteCount / 1000).toStringAsFixed(2)}K)"
                                        : "/10 (${state.item.voteCount})",
                                    style: TextStyle(
                                      fontSize: 4.w > 18 ? 18 : 4.w,
                                      color: grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            state.trailer.key != ""
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                          vertical: 15,
                                        ),
                                        child: Text(
                                          "Trailer :",
                                          style: TextStyle(
                                            fontSize: 5.w > 24 ? 24 : 5.w,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Center(
                                          child: ConstrainedBox(
                                            constraints: const BoxConstraints(
                                              maxHeight: 1200,
                                              maxWidth: 1200,
                                            ),
                                            child: Stack(
                                              children: [
                                                YoutubePlayer(
                                                  controller:
                                                      state.videoController,
                                                  aspectRatio: 16 / 9,
                                                ),
                                                PointerInterceptor(
                                                  child: InkWell(
                                                    onTap: () {
                                                      videoPressed
                                                          ? state
                                                                .videoController
                                                                .pauseVideo()
                                                          : state
                                                                .videoController
                                                                .playVideo();
                                                      videoPressed =
                                                          !videoPressed;
                                                    },
                                                    child: const AspectRatio(
                                                      aspectRatio: 16 / 8,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            state.cast.isNotEmpty
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                          vertical: 15,
                                        ),
                                        child: Text(
                                          "Cast :",
                                          style: TextStyle(
                                            fontSize: 5.w > 24 ? 24 : 5.w,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: SizedBox(
                                          height: 30.w > 185 ? 185 : 30.w,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: state.cast.length,
                                            itemBuilder:
                                                (
                                                  BuildContext context,
                                                  int index,
                                                ) => ActorWidget(
                                                  member: state.cast[index],
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            state.suggestions.isNotEmpty
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          "Recommendations :",
                                          style: TextStyle(
                                            fontSize: 5.w > 24 ? 24 : 5.w,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10.0,
                                          horizontal: 20,
                                        ),
                                        child: SizedBox(
                                          height: 70.w > 400 ? 400 : 70.w,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: state.suggestions.length,
                                            itemBuilder:
                                                (
                                                  BuildContext context,
                                                  int index,
                                                ) => GestureDetector(
                                                  onTap: () => context.go(
                                                    '/${widget.pageType}/${state.suggestions[index].id}',
                                                  ),
                                                  child: FittedBox(
                                                    child: SmallPosterWidget(
                                                      index: index,
                                                      suggestions:
                                                          state.suggestions,
                                                    ),
                                                  ),
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            state.similar.isNotEmpty
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          "Might Also Interest You :",
                                          style: TextStyle(
                                            fontSize: 5.w > 24 ? 24 : 5.w,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10.0,
                                          horizontal: 20,
                                        ),
                                        child: SizedBox(
                                          height: 70.w > 400 ? 400 : 70.w,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: state.similar.length,
                                            itemBuilder:
                                                (
                                                  BuildContext context,
                                                  int index,
                                                ) => GestureDetector(
                                                  onTap: () => context.go(
                                                    '/${widget.pageType}/${state.similar[index].id}',
                                                  ),
                                                  child: FittedBox(
                                                    child: SmallPosterWidget(
                                                      index: index,
                                                      suggestions:
                                                          state.similar,
                                                    ),
                                                  ),
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            state.reviews.isNotEmpty
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          "Reviews :",
                                          style: TextStyle(
                                            fontSize: 5.w > 24 ? 24 : 5.w,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      ListView.builder(
                                        itemCount: state.reviews.length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, int index) =>
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: ReviewWidget(
                                                    review:
                                                        state.reviews[index],
                                                  ),
                                                ),
                                      ),
                                    ],
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : null,
        );
      },
    );
  }
}
