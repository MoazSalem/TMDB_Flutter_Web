import 'package:tmdb_web/core/helpers/endpoint_helper.dart';
import 'package:tmdb_web/core/models/movie.dart';
import 'package:tmdb_web/core/networking/api_service.dart';
import 'package:tmdb_web/core/networking/constants.dart';

class MoviesListRepo {
  final ApiService _apiService;

  MoviesListRepo(this._apiService);

  Future<List<Movie>> getMovies({
    required String category,
    required int currentPage,
  }) {
    final uniqueGenres = !{
      "popular",
      "top_rated",
      "now_playing",
      "upcoming",
    }.contains(category);
    return _apiService.fetchList(
      url: EndpointHelper.getEndPoint(
        category: uniqueGenres ? 'movie' : category,
        discover: uniqueGenres ? true : null,
        genre: uniqueGenres
            ? Constants.categoriesMovies[category].toString()
            : null,
        typeIndex: uniqueGenres ? null : 0,
        page: currentPage,
      ),
      fromJson: (json) => Movie.fromJson(json),
    );
  }
}
