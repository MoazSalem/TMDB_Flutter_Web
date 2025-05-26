import 'package:tmdb_web/core/models/movie.dart';
import 'package:tmdb_web/core/models/popular.dart';
import 'package:tmdb_web/core/models/show.dart';
import 'package:tmdb_web/core/networking/api_service.dart';
import 'package:tmdb_web/core/networking/constants.dart';
import 'package:tmdb_web/private.dart';

class HomeRepo {
  final ApiService _apiService;
  HomeRepo(this._apiService);

  Future<List<PopularItem>> getHomePopular() => _apiService.fetchList(
    "https://api.themoviedb.org/3/trending/all/week?api_key=$apiKey",
    (json) => PopularItem.fromJson(json),
  );

  Future<List<Movie>> getHomeMovies() => _apiService.fetchList(
    "${Constants.getEndPoint(category: 'popular', typeIndex: 0)}1",
    (json) => Movie.fromJson(json),
  );

  Future<List<Show>> getHomeShows() => _apiService.fetchList(
    "${Constants.getEndPoint(category: 'popular', typeIndex: 1)}1",
    (json) => Show.fromJson(json),
  );
}
