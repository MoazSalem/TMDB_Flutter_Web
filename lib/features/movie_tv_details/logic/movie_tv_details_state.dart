part of 'movie_tv_details_cubit.dart';

@immutable
sealed class MovieTvDetailsState {}

final class MovieTvDetailsInitial extends MovieTvDetailsState {}

final class MovieTvDetailsLoading extends MovieTvDetailsState {}

class MovieTvDetailsLoaded extends MovieTvDetailsState {
  final dynamic item;
  final Video trailer;
  final YoutubePlayerController videoController;

  // 1. Make all secondary data nullable.
  //    They will be null during the initial load.
  final List<Cast>? cast;
  final List<PopularItem>? suggestions;
  final List<PopularItem>? similar;
  final List<Review>? reviews;

  MovieTvDetailsLoaded({
    required this.item,
    required this.trailer,
    required this.videoController,
    this.cast,
    this.suggestions,
    this.similar,
    this.reviews,
  });

  // 2. Add a `copyWith` method.
  //    This is crucial for updating the state without losing existing data.
  MovieTvDetailsLoaded copyWith({
    List<Cast>? cast,
    List<PopularItem>? suggestions,
    List<PopularItem>? similar,
    List<Review>? reviews,
  }) {
    return MovieTvDetailsLoaded(
      item: item,
      trailer: trailer,
      videoController: videoController,
      cast: cast ?? this.cast,
      suggestions: suggestions ?? this.suggestions,
      similar: similar ?? this.similar,
      reviews: reviews ?? this.reviews,
    );
  }
}
