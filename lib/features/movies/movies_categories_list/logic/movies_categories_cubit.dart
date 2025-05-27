import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_web/core/models/movie.dart';
import 'package:tmdb_web/features/movies/movies_categories_list/data/repo/movies_categories_repo.dart';

part 'movies_categories_state.dart';

class MoviesCategoriesCubit extends Cubit<MoviesCategoriesState> {
  MoviesCategoriesCubit() : super(MoviesCategoriesInitial());

  getMovies({required String category, required int currentPage}) async {
    emit(MoviesCategoriesLoading());
    final movies = await GetIt.I.get<MoviesCategoriesRepo>().getMovies(
      category: category,
      currentPage: currentPage,
    );
    emit(
      MoviesCategoriesLoaded(
        movies: movies,
        category: category,
        currentPage: currentPage,
      ),
    );
  }
}
