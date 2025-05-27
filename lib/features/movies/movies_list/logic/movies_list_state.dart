part of 'movies_list_cubit.dart';

@immutable
sealed class MoviesListState {}

final class MoviesListInitial extends MoviesListState {}

final class MoviesListLoading extends MoviesListState {}

final class MoviesListLoaded extends MoviesListState {
  final int currentPage;
  final String category;
  final List<Movie> movies;
  MoviesListLoaded({
    required this.movies,
    required this.category,
    required this.currentPage,
  });
}
