import 'package:tmdb_web/core/helpers/endpoint_helper.dart';
import 'package:tmdb_web/core/models/show.dart';
import 'package:tmdb_web/core/networking/api_service.dart';
import 'package:tmdb_web/core/networking/constants.dart';

class ShowsListRepo {
  final ApiService _apiService;

  ShowsListRepo(this._apiService);

  Future<List<Show>> getShows({
    required String category,
    required int currentPage,
  }) {
    final uniqueGenres = !{
      "popular",
      "top_rated",
      "airing_today",
      "on_the_air",
    }.contains(category);
    return _apiService.fetchList(
      url: EndpointHelper.getEndPoint(
        category: uniqueGenres ? 'tv' : category,
        discover: uniqueGenres ? true : null,
        genre: uniqueGenres
            ? Constants.categoriesTv[category].toString()
            : null,
        typeIndex: uniqueGenres ? null : 1,
        page: currentPage,
      ),
      fromJson: (json) => Show.fromJson(json),
    );
  }
}
