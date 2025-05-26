import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

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
}
