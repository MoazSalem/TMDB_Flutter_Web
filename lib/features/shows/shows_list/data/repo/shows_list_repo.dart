import 'package:tmdb_web/core/helpers/endpoint_helper.dart';
import 'package:tmdb_web/core/models/show.dart';
import 'package:tmdb_web/core/networking/api_service.dart';

class ShowsListRepo {
  final ApiService _apiService;

  ShowsListRepo(this._apiService);

  Future<List<Show>> getShows({
    required String category,
    required int currentPage,
  }) => _apiService.fetchList(
    url: EndpointHelper.getEndPoint(
      category: category,
      typeIndex: 1,
      page: currentPage,
    ),
    fromJson: (json) => Show.fromJson(json),
  );
}
