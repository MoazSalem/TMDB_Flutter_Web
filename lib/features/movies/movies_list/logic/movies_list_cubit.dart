import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_web/core/models/movie.dart';
import 'package:tmdb_web/features/movies/movies_list/data/repo/movies_list_repo.dart';

part 'movies_list_state.dart';

class MoviesListCubit extends Cubit<MoviesListState> {
  MoviesListCubit() : super(MoviesListInitial());

  getMovies({required String category, required int currentPage}) async {
    emit(MoviesListLoading());
    final movies = await GetIt.I.get<MoviesListRepo>().getMovies(
      category: category,
      currentPage: currentPage,
    );
    emit(
      MoviesListLoaded(
        movies: movies,
        category: category,
        currentPage: currentPage,
      ),
    );
  }
}
