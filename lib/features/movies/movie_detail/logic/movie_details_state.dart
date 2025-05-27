part of 'movie_details_cubit.dart';

@immutable
sealed class MovieDetailsState {}

final class MovieDetailsInitial extends MovieDetailsState {}

final class MovieDetailsLoading extends MovieDetailsState {}

final class MovieDetailsLoaded extends MovieDetailsState {
  final Movie movie;
  final Video trailer;
  final YoutubePlayerController videoController;
  final List<Cast> cast;
  final List<PopularItem> suggestions;
  final List<PopularItem> similar;
  final List<Review> reviews;
  MovieDetailsLoaded({
    required this.movie,
    required this.trailer,
    required this.videoController,
    required this.cast,
    required this.suggestions,
    required this.similar,
    required this.reviews,
  });
}
