import 'package:tmdb_web/core/helpers/endpoint_helper.dart';
import 'package:tmdb_web/core/models/movie.dart';
import 'package:tmdb_web/core/models/show.dart';
import 'package:tmdb_web/core/networking/api_service.dart';
import 'package:tmdb_web/core/networking/constants.dart';

class MoviesTvListRepo {
  final ApiService _apiService;

  MoviesTvListRepo(this._apiService);

  Future<List<T>> getMoviesOrTv<T>({
    required String type,
    required String category,
    required int currentPage,
  }) {
    final uniqueGenres = !{
      "popular",
      "top_rated",
      "now_playing",
      "upcoming",
      "airing_today",
      "on_the_air",
    }.contains(category);
    return _apiService.fetchList(
      url: EndpointHelper.getEndPoint(
        category: uniqueGenres
            ? type == 'movies'
                  ? 'movie'
                  : 'tv'
            : category,
        discover: uniqueGenres ? true : null,
        genre: uniqueGenres
            ? type == 'movies'
                  ? Constants.moviesGenreMap[category]
                  : Constants.tvGenreMap[category]
            : null,
        typeIndex: uniqueGenres
            ? null
            : type == 'movies'
            ? 0
            : 1,
        page: currentPage,
      ),
      fromJson: (json) => type == 'movies'
          ? Movie.fromJson(json) as T
          : Show.fromJson(json) as T,
    );
  }
}
