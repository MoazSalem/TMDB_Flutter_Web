part of 'shows_list_cubit.dart';

@immutable
sealed class ShowsListState {}

final class ShowsListInitial extends ShowsListState {}

final class ShowsListLoading extends ShowsListState {}

final class ShowsListLoaded extends ShowsListState {
  final String category;
  final int currentPage;
  final List<Show> shows;
  ShowsListLoaded({
    required this.shows,
    required this.category,
    required this.currentPage,
  });
}
