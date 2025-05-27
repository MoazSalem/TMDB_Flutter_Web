import 'package:tmdb_web/core/helpers/endpoint_helper.dart';
import 'package:tmdb_web/core/models/movie.dart';
import 'package:tmdb_web/core/networking/api_service.dart';

class MoviesCategoriesRepo {
  final ApiService _apiService;

  MoviesCategoriesRepo(this._apiService);

  Future<List<Movie>> getMovies({
    required String category,
    required int currentPage,
  }) => _apiService.fetchList(
    url: EndpointHelper.getEndPoint(
      category: category,
      typeIndex: 0,
      page: currentPage,
    ),
    fromJson: (json) => Movie.fromJson(json),
  );
}
