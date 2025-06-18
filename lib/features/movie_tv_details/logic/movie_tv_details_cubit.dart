import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_web/core/models/cast.dart';
import 'package:tmdb_web/core/models/popular.dart';
import 'package:tmdb_web/core/models/reviews.dart';
import 'package:tmdb_web/core/models/videos.dart';
import 'package:tmdb_web/core/networking/error_handling.dart';
import 'package:tmdb_web/features/movie_tv_details/data/repo/movie_tv_details_repo.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

part 'movie_tv_details_state.dart';

class MovieTvDetailsCubit extends Cubit<MovieTvDetailsState> {
  MovieTvDetailsCubit() : super(MovieTvDetailsInitial());

  Future<void> getItem({required int id, required String type}) async {
    final movieTvDetailsRepo = GetIt.I.get<MovieTvDetailsRepo>();

    emit(MovieTvDetailsLoading());
    try {
      final item = await movieTvDetailsRepo.getItem(id: id, type: type);
      final trailer = await movieTvDetailsRepo.getTrailer(id: id, type: type);
      final videoController = YoutubePlayerController();
      if (trailer.key?.isNotEmpty ?? false) {
        videoController.cueVideoById(videoId: trailer.key!);
      }

      // Show the main content to the user immediately.
      emit(
        MovieTvDetailsLoaded(
          item: item,
          trailer: trailer,
          videoController: videoController,
        ),
      );
    } catch (e) {
      final errorMessage = e is ApiException
          ? e.message
          : 'An unexpected error occurred.';
      emit(MovieTvDetailsError(errorMessage));
      return;
    }

    // The user is already seeing the main details. Now we fetch the rest.
    try {
      final results = await Future.wait([
        movieTvDetailsRepo.getCast(id: id, type: type),
        movieTvDetailsRepo.getSuggestions(id: id, type: type),
        movieTvDetailsRepo.getSuggestions(id: id, category: 1, type: type),
        movieTvDetailsRepo.getReviews(id: id, pageNum: 1, type: type),
      ]);

      // Ensure the state is still `Loaded` before updating.
      if (state is MovieTvDetailsLoaded) {
        final currentState = state as MovieTvDetailsLoaded;
        emit(
          currentState.copyWith(
            cast: results[0] as List<Cast>,
            suggestions: results[1] as List<PopularItem>,
            similar: results[2] as List<PopularItem>,
            reviews: results[3] as List<Review>,
          ),
        );
      }
    } catch (e) {
      // We can simply log the error. The user will still see the main content.
      debugPrint('Failed to load secondary details: $e');
    }
  }
}

class MovieTvDetailsError extends MovieTvDetailsState {
  final String message;
  MovieTvDetailsError(this.message);
}
