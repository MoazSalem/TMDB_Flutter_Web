import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_web/core/networking/api_service.dart';
import 'package:tmdb_web/features/categories/data/repo/categories_repo.dart';
import 'package:tmdb_web/features/categories/logic/categories_cubit.dart';
import 'package:tmdb_web/features/home/data/repo/home_repo.dart';
import 'package:tmdb_web/features/home/logic/home_cubit.dart';
import 'package:tmdb_web/features/movie_tv_details/data/repo/movie_tv_details_repo.dart';
import 'package:tmdb_web/features/movie_tv_details/logic/movie_tv_details_cubit.dart';
import 'package:tmdb_web/features/movies_tv_list/data/repo/movies_tv_list_repo.dart';
import 'package:tmdb_web/features/movies_tv_list/logic/movies_tv_list_cubit.dart';
import 'package:tmdb_web/features/search/data/repo/search_repo.dart';
import 'package:tmdb_web/features/search/logic/search_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerLazySingleton<Dio>(() => Dio());

  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt.get<Dio>()));

  getIt.registerLazySingleton<HomeRepo>(
    () => HomeRepo(getIt.get<ApiService>()),
  );

  getIt.registerFactory<CategoriesCubit>(() => CategoriesCubit());

  getIt.registerLazySingleton<CategoriesRepo>(
    () => CategoriesRepo(getIt.get<ApiService>()),
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

  getIt.registerLazySingleton<MovieTvDetailsRepo>(
    () => MovieTvDetailsRepo(getIt.get<ApiService>()),
  );

  getIt.registerFactory<MovieTvDetailsCubit>(() => MovieTvDetailsCubit());
}
