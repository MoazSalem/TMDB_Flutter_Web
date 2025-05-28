import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_web/core/models/cast.dart';
import 'package:tmdb_web/core/models/popular.dart';
import 'package:tmdb_web/core/models/reviews.dart';
import 'package:tmdb_web/core/models/videos.dart';
import 'package:tmdb_web/features/movie_tv_details/data/repo/movie_tv_details_repo.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

part 'movie_tv_details_state.dart';

class MovieTvDetailsCubit extends Cubit<MovieTvDetailsState> {
  MovieTvDetailsCubit() : super(MovieTvDetailsInitial());

  getItem({required int id, required String type}) async {
    MovieTvDetailsRepo movieTvDetailsRepo = GetIt.I.get<MovieTvDetailsRepo>();
    final item = await movieTvDetailsRepo.getItem(id: id, type: type);
    final trailer = await movieTvDetailsRepo.getTrailer(id: id, type: type);
    final cast = await movieTvDetailsRepo.getCast(id: id, type: type);
    final suggestions = await movieTvDetailsRepo.getSuggestions(
      id: id,
      type: type,
    );
    final similar = await movieTvDetailsRepo.getSuggestions(
      id: id,
      category: 1,
      type: type,
    );
    final reviews = await movieTvDetailsRepo.getReviews(
      id: id,
      pageNum: 1,
      type: type,
    );
    final videoController = YoutubePlayerController();
    videoController.cueVideoById(videoId: trailer.key!);
    emit(
      MovieTvDetailsLoaded(
        item: item,
        trailer: trailer,
        videoController: videoController,
        cast: cast,
        suggestions: suggestions,
        similar: similar,
        reviews: reviews,
      ),
    );
  }
}
