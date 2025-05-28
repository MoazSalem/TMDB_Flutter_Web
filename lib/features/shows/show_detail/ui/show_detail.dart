import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tmdb_web/core/helpers/widgets_helper.dart';
import 'package:tmdb_web/features/shows/show_detail/logic/show_details_cubit.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:tmdb_web/core/shared_widgets/suggestion_widget.dart';
import 'package:tmdb_web/core/shared_widgets/actor_widget.dart';
import 'package:tmdb_web/core/shared_widgets/categories_widget.dart';
import 'package:tmdb_web/core/shared_widgets/review_widget.dart';

// This page is opened when you press on a tv show
class ShowDetails extends StatefulWidget {
  const ShowDetails({super.key});

  @override
  State<ShowDetails> createState() => _ShowDetailsState();
}

class _ShowDetailsState extends State<ShowDetails> {
  late double width;
  final ScrollController scrollController = ScrollController();
  final Color grey = Colors.grey.shade400;
  bool videoPressed = false;
  bool loading = true;
  bool seeMore = false;
  int parsedId = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    width = MediaQuery.of(context).size.width;
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowDetailsCubit, ShowDetailsState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).canvasColor,
          body: state is ShowDetailsLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Color(0xff09b5e1)),
                )
              : state is ShowDetailsLoaded
              ? ListView(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: state.show.posterPath != ""
                          ? Image.network(
                              fit: BoxFit.cover,
                              "https://image.tmdb.org/t/p/original/${state.show.backdropPath ?? state.show.posterPath}",
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 20),
                            child: Text(
                              state.show.name!,
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
                            child: SizedBox(
                              width: 90.w > 550 ? 550 : 90.w,
                              child: FittedBox(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "${state.show.status}",
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
                                      "${state.show.numberOfSeasons} Season${state.show.numberOfSeasons! > 1 ? "s" : ""}",
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
                                      "${state.show.numberOfEpisodes} Episodes",
                                      style: TextStyle(
                                        fontSize: 4.w > 18 ? 18 : 4.w,
                                        color: grey,
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5.0,
                                      ),
                                      child: Text("-"),
                                    ),
                                    Text(
                                      WidgetsHelper.runtimeToHours(
                                        state.show.episodeRunTime!,
                                      ),
                                      style: TextStyle(
                                        fontSize: 4.w > 18 ? 18 : 4.w,
                                        color: grey,
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5.0,
                                      ),
                                      child: Text("-"),
                                    ),
                                    Text(
                                      state.show.firstAirDate!.split('-')[0],
                                      style: TextStyle(
                                        fontSize: 4.w > 18 ? 18 : 4.w,
                                        color: grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          state.show.genres!.isNotEmpty
                              ? SizedBox(
                                  width: 90.w > 120 * state.show.genres!.length
                                      ? (120 * state.show.genres!.length)
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
                                          itemCount: state.show.genres!.length,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder:
                                              (
                                                BuildContext context,
                                                int index,
                                              ) => categoriesWidget(
                                                index: index,
                                                movie: state.show,
                                                context: context,
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
                              state.show.overview!,
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
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: const Color(0xff8fcea2),
                                  size: 4.w > 18 ? 18 : 4.w,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  state.show.voteAverage!
                                      .toStringAsFixed(1)
                                      .replaceFirst(RegExp(r'\.?'), ''),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 4.w > 18 ? 18 : 4.w,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  state.show.voteCount! > 1000
                                      ? "/10 (${(state.show.voteCount! / 1000).toStringAsFixed(2)}K)"
                                      : "/10 (${state.show.voteCount})",
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                        ? state.videoController
                                                              .pauseVideo()
                                                        : state.videoController
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                        vertical: 15,
                                      ),
                                      child: Text(
                                        "Shows Cast :",
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
                                              ) => actorWidget(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                  '/tv/${state.suggestions[index].id}',
                                                ),
                                                child: FittedBox(
                                                  child: suggestionWidget(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                  '/tv/${state.similar[index].id}',
                                                ),
                                                child: FittedBox(
                                                  child: suggestionWidget(
                                                    index: index,
                                                    suggestions: state.similar,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    LiveList.options(
                                      options: const LiveOptions(
                                        showItemInterval: Duration(
                                          milliseconds: 50,
                                        ),
                                        showItemDuration: Duration(
                                          milliseconds: 200,
                                        ),
                                        reAnimateOnVisibility: false,
                                      ),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (
                                            BuildContext context,
                                            int index,
                                            Animation<double> animation,
                                          ) => FadeTransition(
                                            opacity: Tween<double>(
                                              begin: 0,
                                              end: 1,
                                            ).animate(animation),
                                            // And slide transition
                                            child: SlideTransition(
                                              position: Tween<Offset>(
                                                begin: const Offset(0, -0.1),
                                                end: Offset.zero,
                                              ).animate(animation),
                                              // Paste you Widget
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: reviewWidget(
                                                  review: state.reviews[index],
                                                ),
                                              ),
                                            ),
                                          ),
                                      itemCount: seeMore
                                          ? state.reviews.length
                                          : state.reviews.length > 1
                                          ? 2
                                          : 1,
                                    ),
                                    state.reviews.length > 2
                                        ? Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                onTap: () {
                                                  seeMore = !seeMore;
                                                  // todo: fix this
                                                  setState(() {});
                                                },
                                                child: SizedBox(
                                                  height: 50,
                                                  width: 200,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        seeMore
                                                            ? "Show Less "
                                                            : " See More ",
                                                      ),
                                                      Icon(
                                                        seeMore
                                                            ? Icons.arrow_upward
                                                            : Icons
                                                                  .arrow_downward,
                                                        size: 14,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container(),
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ],
                )
              : const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
