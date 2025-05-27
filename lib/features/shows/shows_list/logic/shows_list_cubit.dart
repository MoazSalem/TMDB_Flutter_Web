import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_web/core/models/show.dart';
import 'package:tmdb_web/features/shows/shows_list/data/repo/shows_list_repo.dart';

part 'shows_list_state.dart';

class ShowsListCubit extends Cubit<ShowsListState> {
  ShowsListCubit() : super(ShowsListInitial());

  void getShows({required String category, required int currentPage}) async {
    emit(ShowsListLoading());
    final shows = await GetIt.I.get<ShowsListRepo>().getShows(
      category: category,
      currentPage: currentPage,
    );
    emit(
      ShowsListLoaded(
        shows: shows,
        category: category,
        currentPage: currentPage,
      ),
    );
  }
}
