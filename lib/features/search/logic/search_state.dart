part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchLoaded extends SearchState {
  final int type;
  final searchResult;
  SearchLoaded({required this.searchResult, required this.type});
}
