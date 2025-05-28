import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_web/features/movies_tv_list/data/repo/movies_tv_list_repo.dart';

part 'movies_tv_list_state.dart';

class MoviesTvListCubit extends Cubit<MoviesTvListState> {
  MoviesTvListCubit() : super(MoviesTvListInitial());

  getMoviesOrTv({
    required String category,
    required int currentPage,
    required String type,
  }) async {
    emit(MoviesTvListLoading());
    final list = await GetIt.I.get<MoviesTvListRepo>().getMoviesOrTv(
      type: type,
      category: category,
      currentPage: currentPage,
    );
    emit(
      MoviesTvListLoaded(
        list: list,
        category: category,
        currentPage: currentPage,
      ),
    );
  }
}
