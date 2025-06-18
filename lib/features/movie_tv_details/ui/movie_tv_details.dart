import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tmdb_web/core/shared_widgets/custom_app_bar.dart';
import 'package:tmdb_web/core/shared_widgets/rating_widget.dart';
import 'package:tmdb_web/features/movie_tv_details/logic/movie_tv_details_cubit.dart';
import 'package:tmdb_web/features/movie_tv_details/ui/widgets/cast_list_widget.dart';
import 'package:tmdb_web/features/movie_tv_details/ui/widgets/loading_skeleton_details.dart';
import 'package:tmdb_web/features/movie_tv_details/ui/widgets/review_list_widget.dart';
import 'package:tmdb_web/features/movie_tv_details/ui/widgets/suggestions_list_widget.dart';
import 'package:tmdb_web/features/movie_tv_details/ui/widgets/top_cover_widget.dart';
import 'package:tmdb_web/features/movie_tv_details/ui/widgets/trailer_widget.dart';

// This page is opened when you press on a item
class MovieTvDetails extends StatefulWidget {
  const MovieTvDetails({super.key, required this.pageType});
  final String pageType;

  @override
  State<MovieTvDetails> createState() => _MovieTvDetailsState();
}

class _MovieTvDetailsState extends State<MovieTvDetails> {
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
          appBar: CustomAppBar(isMovie: widget.pageType == "movies"),
          body: state is MovieTvDetailsLoading
              ? LoadingSkeletonDetails()
              : state is MovieTvDetailsLoaded
              ? SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TopCoverWidget(
                          item: state.item,
                          pageType: widget.pageType,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          state.item.overview,
                          style: TextStyle(
                            fontSize: 14.sp > 20 ? 20 : 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        RatingWidget(
                          voteCount: state.item.voteCount,
                          voteAverage: state.item.voteAverage,
                          ratingSize: 4.w > 18 ? 18 : 4.w,
                        ),
                        if (state.trailer.key != "")
                          TrailerWidget(videoController: state.videoController),
                        if (state.cast != null && state.cast!.isNotEmpty)
                          CastListWidget(cast: state.cast!),
                        if (state.suggestions != null &&
                            state.suggestions!.isNotEmpty)
                          SuggestionsListWidget(
                            suggestions: state.suggestions,
                            pageType: widget.pageType,
                            title: "Recommendations",
                          ),
                        if (state.similar != null && state.similar!.isNotEmpty)
                          SuggestionsListWidget(
                            suggestions: state.similar,
                            pageType: widget.pageType,
                            title: "Might Also Interest You",
                          ),
                        if (state.reviews != null && state.reviews!.isNotEmpty)
                          ReviewListWidget(reviews: state.reviews!),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                )
              : null,
        );
      },
    );
  }
}
