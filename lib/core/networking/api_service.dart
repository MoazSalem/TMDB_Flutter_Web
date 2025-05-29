import 'package:dio/dio.dart';
import 'package:tmdb_web/core/networking/constants.dart';
import 'package:tmdb_web/core/networking/error_handling.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);
  Future<Response> get({required String url, bool useBaseUrl = true}) async {
    try {
      final fullUrl = '${useBaseUrl ? Constants.baseUrl : ''}$url';
      return await _dio.get(fullUrl);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } catch (e) {
      throw ApiException('Unknown error', details: e.toString());
    }
  }

  Future<List<T>> fetchList<T>({
    required String url,
    required T Function(Map<String, dynamic>) fromJson,
    String dataKey = 'results',
  }) async {
    try {
      final response = await get(url: url, useBaseUrl: false);
      if (response.statusCode == 200) {
        final List results = response.data[dataKey];
        return results.map<T>((item) => fromJson(item)).toList();
      } else {
        throw Exception('Failed with status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } catch (e) {
      throw ApiException('Unknown error', details: e.toString());
    }
  }
}
