import 'package:tmdb_web/core/helpers/endpoint_helper.dart';
import 'package:tmdb_web/core/models/movie.dart';
import 'package:tmdb_web/core/models/show.dart';
import 'package:tmdb_web/core/networking/api_service.dart';

class SearchRepo {
  final ApiService _apiService;

  SearchRepo(this._apiService);

  Future<List<T>> search<T>({required int type, required String query}) =>
      _apiService.fetchList(
        url: EndpointHelper.getEndPoint(
          category: type == 0 ? 'search/movie' : 'search/tv',
          query: query,
        ),
        fromJson: (json) =>
            type == 0 ? Movie.fromJson(json) as T : Show.fromJson(json) as T,
      );
}
