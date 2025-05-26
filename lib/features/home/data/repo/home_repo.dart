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
    url: "https://api.themoviedb.org/3/trending/all/week?api_key=$apiKey",
    fromJson: (json) => PopularItem.fromJson(json),
  );

  Future<List<Movie>> getHomeMovies() => _apiService.fetchList(
    url: "${Constants.getEndPoint(category: 'popular', typeIndex: 0)}1",
    fromJson: (json) => Movie.fromJson(json),
  );

  Future<List<Show>> getHomeShows() => _apiService.fetchList(
    url: "${Constants.getEndPoint(category: 'popular', typeIndex: 1)}1",
    fromJson: (json) => Show.fromJson(json),
  );
}
