import 'package:tmdb_web/core/helpers/endpoint_helper.dart';
import 'package:tmdb_web/core/models/movie.dart';
import 'package:tmdb_web/core/models/show.dart';
import 'package:tmdb_web/core/networking/api_service.dart';
import 'package:tmdb_web/core/networking/constants.dart';

class CategoriesRepo {
  final ApiService _apiService;
  CategoriesRepo(this._apiService);

  Future<List<dynamic>> getCategory(
    final String type,
    final Category category,
  ) => _apiService.fetchList(
    url: EndpointHelper.getEndPoint(
      category: category.apiKey,
      typeIndex: type == 'movies' ? 0 : 1,
    ),
    fromJson: (json) =>
        type == 'movies' ? Movie.fromJson(json) : Show.fromJson(json),
  );
}
