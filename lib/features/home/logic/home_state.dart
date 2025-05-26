part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<Movie> movies;
  final List<Show> tvShows;
  final List<PopularItem> popular;
  HomeLoaded({
    required this.movies,
    required this.tvShows,
    required this.popular,
  });
}
