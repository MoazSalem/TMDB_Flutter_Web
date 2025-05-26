import 'package:dio/dio.dart';
import 'package:tmdb_web/core/networking/constants.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);
  Future<Response> get(String url, {bool useBaseUrl = true}) async =>
      await _dio.get('${useBaseUrl ? Constants.baseUrl : ''}$url');

  Future<List<T>> fetchList<T>(
    String url,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    try {
      final response = await get(url, useBaseUrl: false);
      if (response.statusCode == 200) {
        final List results = response.data["results"];
        return results.map<T>((item) => fromJson(item)).toList();
      } else {
        throw Exception('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
