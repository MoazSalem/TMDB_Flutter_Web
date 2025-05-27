import 'package:tmdb_web/core/helpers/endpoint_helper.dart';
import 'package:tmdb_web/core/models/movie.dart';
import 'package:tmdb_web/core/models/popular.dart';
import 'package:tmdb_web/core/models/show.dart';
import 'package:tmdb_web/core/networking/api_service.dart';

class HomeRepo {
  final ApiService _apiService;
  HomeRepo(this._apiService);

  Future<List<PopularItem>> getHomePopular() => _apiService.fetchList(
    url: EndpointHelper.getEndPoint(category: 'trending/all/week'),
    fromJson: (json) => PopularItem.fromJson(json),
  );

  Future<List<Movie>> getHomeMovies() => _apiService.fetchList(
    url: EndpointHelper.getEndPoint(category: 'popular', typeIndex: 0, page: 1),
    fromJson: (json) => Movie.fromJson(json),
  );

  Future<List<Show>> getHomeShows() => _apiService.fetchList(
    url: EndpointHelper.getEndPoint(category: 'popular', typeIndex: 1, page: 1),
    fromJson: (json) => Show.fromJson(json),
  );
}
