import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tmdb_web/core/networking/api_service.dart';
import 'package:tmdb_web/features/home/data/repo/home_repo.dart';
import 'package:tmdb_web/features/home/logic/home_cubit.dart';
import 'package:tmdb_web/features/movies/movies_list/data/repo/movies_list_repo.dart';
import 'package:tmdb_web/features/movies/movies_list/logic/movies_list_cubit.dart';
import 'package:tmdb_web/features/search/data/repo/search_repo.dart';
import 'package:tmdb_web/features/search/logic/search_cubit.dart';
import 'package:tmdb_web/features/shows/shows_list/data/repo/shows_list_repo.dart';
import 'package:tmdb_web/features/shows/shows_list/logic/shows_list_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  Dio dio = Dio();
  dio.interceptors.add(
    PrettyDioLogger(
      requestBody: true,
      requestHeader: true,
      responseHeader: true,
    ),
  );
  getIt.registerLazySingleton<Dio>(() => dio);

  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt.get<Dio>()));

  getIt.registerLazySingleton<HomeRepo>(
    () => HomeRepo(getIt.get<ApiService>()),
  );

  getIt.registerLazySingleton<HomeCubit>(() => HomeCubit());

  getIt.registerFactory<MoviesListRepo>(
    () => MoviesListRepo(getIt.get<ApiService>()),
  );

  getIt.registerFactory<MoviesListCubit>(() => MoviesListCubit());

  getIt.registerFactory<ShowsListRepo>(
    () => ShowsListRepo(getIt.get<ApiService>()),
  );

  getIt.registerFactory<ShowsListCubit>(() => ShowsListCubit());

  getIt.registerFactory<SearchRepo>(() => SearchRepo(getIt.get<ApiService>()));

  getIt.registerFactory<SearchCubit>(() => SearchCubit());
}
