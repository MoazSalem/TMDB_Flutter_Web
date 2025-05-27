part of 'movies_categories_cubit.dart';

@immutable
sealed class MoviesCategoriesState {}

final class MoviesCategoriesInitial extends MoviesCategoriesState {}

final class MoviesCategoriesLoading extends MoviesCategoriesState {}

final class MoviesCategoriesLoaded extends MoviesCategoriesState {
  final int currentPage;
  final String category;
  final List<Movie> movies;
  MoviesCategoriesLoaded({
    required this.movies,
    required this.category,
    required this.currentPage,
  });
}
