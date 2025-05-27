import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_web/core/networking/api_service.dart';
import 'package:tmdb_web/features/home/data/repo/home_repo.dart';
import 'package:tmdb_web/features/home/logic/home_cubit.dart';
import 'package:tmdb_web/features/movies/movie_detail/data/repo/movie_details_repo.dart';
import 'package:tmdb_web/features/movies/movie_detail/logic/movie_details_cubit.dart';
import 'package:tmdb_web/features/movies/movies_list/data/repo/movies_list_repo.dart';
import 'package:tmdb_web/features/movies/movies_list/logic/movies_list_cubit.dart';
import 'package:tmdb_web/features/search/data/repo/search_repo.dart';
import 'package:tmdb_web/features/search/logic/search_cubit.dart';
import 'package:tmdb_web/features/shows/show_detail/data/repo/show_details_repo.dart';
import 'package:tmdb_web/features/shows/show_detail/logic/show_details_cubit.dart';
import 'package:tmdb_web/features/shows/shows_list/data/repo/shows_list_repo.dart';
import 'package:tmdb_web/features/shows/shows_list/logic/shows_list_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerLazySingleton<Dio>(() => Dio());

  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt.get<Dio>()));

  getIt.registerLazySingleton<HomeRepo>(
    () => HomeRepo(getIt.get<ApiService>()),
  );

  getIt.registerLazySingleton<HomeCubit>(() => HomeCubit());

  getIt.registerLazySingleton<MoviesListRepo>(
    () => MoviesListRepo(getIt.get<ApiService>()),
  );

  getIt.registerLazySingleton<MoviesListCubit>(() => MoviesListCubit());

  getIt.registerLazySingleton<ShowsListRepo>(
    () => ShowsListRepo(getIt.get<ApiService>()),
  );

  getIt.registerLazySingleton<ShowsListCubit>(() => ShowsListCubit());

  getIt.registerLazySingleton<SearchRepo>(
    () => SearchRepo(getIt.get<ApiService>()),
  );

  getIt.registerLazySingleton<SearchCubit>(() => SearchCubit());

  getIt.registerLazySingleton<MovieDetailsRepo>(
    () => MovieDetailsRepo(getIt.get<ApiService>()),
  );

  getIt.registerLazySingleton<MovieDetailsCubit>(() => MovieDetailsCubit());

  getIt.registerLazySingleton<ShowDetailsRepo>(
    () => ShowDetailsRepo(getIt.get<ApiService>()),
  );

  getIt.registerLazySingleton<ShowDetailsCubit>(() => ShowDetailsCubit());
}
