import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_web/core/networking/api_service.dart';
import 'package:tmdb_web/features/home/data/repo/home_repo.dart';
import 'package:tmdb_web/features/home/logic/home_cubit.dart';
import 'package:tmdb_web/features/movies/movie_detail/data/repo/movie_details_repo.dart';
import 'package:tmdb_web/features/movies/movie_detail/logic/movie_details_cubit.dart';
import 'package:tmdb_web/features/movies_tv_list/data/repo/movies_tv_list_repo.dart';
import 'package:tmdb_web/features/movies_tv_list/logic/movies_tv_list_cubit.dart';
import 'package:tmdb_web/features/search/data/repo/search_repo.dart';
import 'package:tmdb_web/features/search/logic/search_cubit.dart';
import 'package:tmdb_web/features/shows/show_detail/data/repo/show_details_repo.dart';
import 'package:tmdb_web/features/shows/show_detail/logic/show_details_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerLazySingleton<Dio>(() => Dio());

  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt.get<Dio>()));

  getIt.registerLazySingleton<HomeRepo>(
    () => HomeRepo(getIt.get<ApiService>()),
  );

  getIt.registerFactory<HomeCubit>(() => HomeCubit());

  getIt.registerLazySingleton<MoviesTvListRepo>(
    () => MoviesTvListRepo(getIt.get<ApiService>()),
  );

  getIt.registerFactory<MoviesTvListCubit>(() => MoviesTvListCubit());

  getIt.registerLazySingleton<SearchRepo>(
    () => SearchRepo(getIt.get<ApiService>()),
  );

  getIt.registerFactory<SearchCubit>(() => SearchCubit());

  getIt.registerLazySingleton<MovieDetailsRepo>(
    () => MovieDetailsRepo(getIt.get<ApiService>()),
  );

  getIt.registerFactory<MovieDetailsCubit>(() => MovieDetailsCubit());

  getIt.registerLazySingleton<ShowDetailsRepo>(
    () => ShowDetailsRepo(getIt.get<ApiService>()),
  );

  getIt.registerFactory<ShowDetailsCubit>(() => ShowDetailsCubit());
}
