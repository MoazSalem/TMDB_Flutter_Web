import 'package:tmdb_web/core/helpers/endpoint_helper.dart';
import 'package:tmdb_web/core/models/cast.dart';
import 'package:tmdb_web/core/models/movie.dart';
import 'package:tmdb_web/core/models/popular.dart';
import 'package:tmdb_web/core/models/reviews.dart';
import 'package:tmdb_web/core/models/videos.dart';
import 'package:tmdb_web/core/networking/api_service.dart';

class MovieDetailsRepo {
  final ApiService _apiService;

  MovieDetailsRepo(this._apiService);

  Future<Movie> getMovie({required int id}) async => Movie.fromJson(
    (await _apiService.get(
      url: EndpointHelper.getEndPoint(id: id, typeIndex: 0),
      useBaseUrl: false,
    )).data,
  );

  Future<Video> getTrailer({required int id}) async =>
      (await _apiService.fetchList(
        url: EndpointHelper.getEndPoint(
          id: id,
          category: '/videos',
          typeIndex: 0,
        ),
        fromJson: (json) => Video.fromJson(json),
      )).firstWhere(
        (element) => element.type == "Trailer",
        orElse: () => emptyVideo,
      );

  Future<List<Cast>> getCast({required int id}) => _apiService.fetchList(
    url: EndpointHelper.getEndPoint(id: id, category: '/credits', typeIndex: 0),
    fromJson: (json) => Cast.fromJson(json),
    dataKey: 'cast',
  );

  Future<List<PopularItem>> getSuggestions({required int id, int type = 0}) =>
      _apiService.fetchList(
        url: EndpointHelper.getEndPoint(
          id: id,
          category: type == 0 ? '/recommendations' : '/similar',
          typeIndex: 0,
        ),
        fromJson: (json) => PopularItem.fromJson(json),
      );

  Future<List<Review>> getReviews({required int id, required int pageNum}) =>
      _apiService.fetchList(
        url: EndpointHelper.getEndPoint(
          id: id,
          category: '/reviews',
          typeIndex: 0,
          page: pageNum,
        ),
        fromJson: (json) => Review.fromJson(json),
      );
}
