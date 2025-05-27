part of 'show_details_cubit.dart';

@immutable
sealed class ShowDetailsState {}

final class ShowDetailsInitial extends ShowDetailsState {}

final class ShowDetailsLoading extends ShowDetailsState {}

final class ShowDetailsLoaded extends ShowDetailsState {
  final Show show;
  final Video trailer;
  final YoutubePlayerController videoController;
  final List<Cast> cast;
  final List<PopularItem> suggestions;
  final List<PopularItem> similar;
  final List<Review> reviews;
  ShowDetailsLoaded({
    required this.show,
    required this.trailer,
    required this.videoController,
    required this.cast,
    required this.suggestions,
    required this.similar,
    required this.reviews,
  });
}
