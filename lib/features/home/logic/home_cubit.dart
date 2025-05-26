import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_web/core/models/movie.dart';
import 'package:tmdb_web/core/models/popular.dart';
import 'package:tmdb_web/core/models/show.dart';
import 'package:tmdb_web/features/home/data/repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> load() async {
    emit(HomeLoading());

    HomeRepo homeRepo = GetIt.I.get<HomeRepo>();

    List<PopularItem> popular = await homeRepo.getHomePopular();

    List<Movie> movies = await homeRepo.getHomeMovies();

    List<Show> shows = await homeRepo.getHomeShows();

    emit(HomeLoaded(movies: movies, tvShows: shows, popular: popular));
  }
}
