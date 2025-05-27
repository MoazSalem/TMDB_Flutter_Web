import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_web/core/models/cast.dart';
import 'package:tmdb_web/core/models/movie.dart';
import 'package:tmdb_web/core/models/popular.dart';
import 'package:tmdb_web/core/models/reviews.dart';
import 'package:tmdb_web/core/models/videos.dart';
import 'package:tmdb_web/features/movies/movie_detail/data/repo/movie_details_repo.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

part 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  MovieDetailsCubit() : super(MovieDetailsInitial());

  getMovie({required int id}) async {
    MovieDetailsRepo movieDetailsRepo = GetIt.I.get<MovieDetailsRepo>();
    final movie = await movieDetailsRepo.getMovie(id: id);
    final trailer = await movieDetailsRepo.getTrailer(id: id);
    final cast = await movieDetailsRepo.getCast(id: id);
    final suggestions = await movieDetailsRepo.getSuggestions(id: id);
    final similar = await movieDetailsRepo.getSuggestions(id: id, type: 1);
    final reviews = await movieDetailsRepo.getReviews(id: id, pageNum: 1);
    final videoController = YoutubePlayerController();
    videoController.cueVideoById(videoId: trailer.key!);
    emit(
      MovieDetailsLoaded(
        movie: movie,
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
