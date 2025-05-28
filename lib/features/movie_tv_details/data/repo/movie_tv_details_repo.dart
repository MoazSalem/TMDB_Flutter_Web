import 'package:tmdb_web/core/helpers/endpoint_helper.dart';
import 'package:tmdb_web/core/models/cast.dart';
import 'package:tmdb_web/core/models/movie.dart';
import 'package:tmdb_web/core/models/popular.dart';
import 'package:tmdb_web/core/models/reviews.dart';
import 'package:tmdb_web/core/models/show.dart';
import 'package:tmdb_web/core/models/videos.dart';
import 'package:tmdb_web/core/networking/api_service.dart';

class MovieTvDetailsRepo {
  final ApiService _apiService;

  MovieTvDetailsRepo(this._apiService);

  Future<T> getItem<T>({required int id, required String type}) async {
    final item = await _apiService.get(
      url: EndpointHelper.getEndPoint(
        id: id,
        typeIndex: type == 'movies' ? 0 : 1,
      ),
      useBaseUrl: false,
    );
    return type == 'movies'
        ? Movie.fromJson(item.data) as T
        : Show.fromJson(item.data) as T;
  }

  Future<Video> getTrailer({required int id, required String type}) async =>
      (await _apiService.fetchList(
        url: EndpointHelper.getEndPoint(
          id: id,
          category: '/videos',
          typeIndex: type == 'movies' ? 0 : 1,
        ),
        fromJson: (json) => Video.fromJson(json),
      )).firstWhere(
        (element) => element.type == "Trailer",
        orElse: () => emptyVideo,
      );

  Future<List<Cast>> getCast({required int id, required String type}) =>
      _apiService.fetchList(
        url: EndpointHelper.getEndPoint(
          id: id,
          category: '/credits',
          typeIndex: type == 'movies' ? 0 : 1,
        ),
        fromJson: (json) => Cast.fromJson(json),
        dataKey: 'cast',
      );

  Future<List<PopularItem>> getSuggestions({
    required int id,
    int category = 0,
    required String type,
  }) => _apiService.fetchList(
    url: EndpointHelper.getEndPoint(
      id: id,
      category: category == 0 ? '/recommendations' : '/similar',
      typeIndex: type == 'movies' ? 0 : 1,
    ),
    fromJson: (json) => PopularItem.fromJson(json),
  );

  Future<List<Review>> getReviews({
    required int id,
    required int pageNum,
    required String type,
  }) => _apiService.fetchList(
    url: EndpointHelper.getEndPoint(
      id: id,
      category: '/reviews',
      typeIndex: type == 'movies' ? 0 : 1,
      page: pageNum,
    ),
    fromJson: (json) => Review.fromJson(json),
  );
}
