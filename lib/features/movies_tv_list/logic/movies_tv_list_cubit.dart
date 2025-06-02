import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_web/core/networking/error_handling.dart';
import 'package:tmdb_web/features/movies_tv_list/data/repo/movies_tv_list_repo.dart';

part 'movies_tv_list_state.dart';

class MoviesTvListCubit extends Cubit<MoviesTvListState> {
  MoviesTvListCubit() : super(MoviesTvListInitial());

  getMoviesOrTv({
    required String category,
    required String currentPages,
    required String type,
  }) async {
    List<dynamic>? list = [];
    emit(MoviesTvListLoading());
    try {
      list = await GetIt.I.get<MoviesTvListRepo>().getMoviesOrTv(
        type: type,
        category: category,
        currentPage: int.parse(currentPages.split('-').first),
      );
      list += await GetIt.I.get<MoviesTvListRepo>().getMoviesOrTv(
        type: type,
        category: category,
        currentPage: int.parse(currentPages.split('-').last),
      );
      emit(
        MoviesTvListLoaded(
          list: list,
          category: category,
          currentPages: currentPages,
        ),
      );
    } catch (e) {
      if (e is ApiException) {
        debugPrint('Search failed: ${e.message}');
      } else {
        debugPrint('Unexpected error: $e');
      }
    }
  }
}
