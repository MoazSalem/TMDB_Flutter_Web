import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tmdb_web/core/networking/api_service.dart';
import 'package:tmdb_web/features/home/data/repo/home_repo.dart';
import 'package:tmdb_web/features/home/logic/home_cubit.dart';
import 'package:tmdb_web/features/movies/movies_categories_list/data/repo/movies_categories_repo.dart';
import 'package:tmdb_web/features/movies/movies_categories_list/logic/movies_categories_cubit.dart';

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

  getIt.registerFactory<MoviesCategoriesRepo>(
    () => MoviesCategoriesRepo(getIt.get<ApiService>()),
  );

  getIt.registerFactory<MoviesCategoriesCubit>(() => MoviesCategoriesCubit());
}
