part of 'movie_tv_details_cubit.dart';

@immutable
sealed class MovieTvDetailsState {}

final class MovieTvDetailsInitial extends MovieTvDetailsState {}

final class MovieTvDetailsLoading extends MovieTvDetailsState {}

final class MovieTvDetailsLoaded extends MovieTvDetailsState {
  final dynamic item;
  final Video trailer;
  final YoutubePlayerController videoController;
  final List<Cast> cast;
  final List<PopularItem> suggestions;
  final List<PopularItem> similar;
  final List<Review> reviews;
  MovieTvDetailsLoaded({
    required this.item,
    required this.trailer,
    required this.videoController,
    required this.cast,
    required this.suggestions,
    required this.similar,
    required this.reviews,
  });
}
