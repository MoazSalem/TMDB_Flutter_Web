part of 'movies_tv_list_cubit.dart';

@immutable
sealed class MoviesTvListState {}

final class MoviesTvListInitial extends MoviesTvListState {}

final class MoviesTvListLoading extends MoviesTvListState {}

final class MoviesTvListLoaded extends MoviesTvListState {
  final String currentPages;
  final String category;
  final dynamic list;
  MoviesTvListLoaded({
    required this.list,
    required this.category,
    required this.currentPages,
  });
}
