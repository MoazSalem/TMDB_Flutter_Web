import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_web/core/models/tv.dart';
import 'package:tmdb_web/core/models/videos.dart';
import 'package:tmdb_web/core/models/reviews.dart';
import 'package:tmdb_web/core/models/cast.dart';
import 'package:tmdb_web/core/models/popular.dart';
import 'package:tmdb_web/private.dart';

// This is used to get the data from the rest api endpoint
class TVService {
  Dio dio = GetIt.I.get<Dio>();
  Future<List<TvShows>> getShows({
    required int page,
    required String endPoint,
  }) async {
    endPoint += "$page";
    List<TvShows> tvShows = [];
    Response response = await dio.get(endPoint);
    if (response.statusCode == 200) {
      var body = response.data;
      // movies are called results in the api
      body["results"].forEach((tvShowData) {
        TvShows newTvShow = TvShows.fromJson(tvShowData);
        tvShows.add(newTvShow);
      });
    } else {
      throw Exception();
    }

    return tvShows;
  }

  Future<List<TvShows>> getTrendingShows({required int page}) async {
    String endPoint =
        "https://api.themoviedb.org/3/trending/tv/day?api_key=$apiKey&language=en-US&page=$page";
    List<TvShows> tvShows = [];
    Response response = await dio.get(endPoint);
    if (response.statusCode == 200) {
      var body = response.data;
      body["results"].forEach((tvShowData) {
        TvShows newTvShow = TvShows.fromJson(tvShowData);
        tvShows.add(newTvShow);
      });
    } else {
      throw Exception();
    }

    return tvShows;
  }

  Future<TvShows> getShow({required int id}) async {
    String endPoint =
        "https://api.themoviedb.org/3/tv/$id?api_key=$apiKey&language=en-US";
    late TvShows show;
    Response response = await dio.get(endPoint);
    if (response.statusCode == 200) {
      var body = response.data;
      // movies are called results in the api
      show = TvShows.fromJson(body);
    } else {
      throw Exception();
    }
    return show;
  }

  Future<List<Cast>> getCast({required int id}) async {
    String endPoint =
        "https://api.themoviedb.org/3/tv/$id/credits?api_key=$apiKey&language=en-US";
    List<Cast> casts = [];
    Response response = await dio.get(endPoint);
    if (response.statusCode == 200) {
      var body = response.data;
      body["cast"].forEach((castData) {
        Cast newCast = Cast.fromJson(castData);
        casts.add(newCast);
      });
    } else {
      throw Exception();
    }

    return casts;
  }

  Future<List<Results>> getSuggestions({required int id, int type = 0}) async {
    List<String> types = ["recommendations", "similar"];
    String endPoint =
        "https://api.themoviedb.org/3/tv/$id/${types[type]}?api_key=$apiKey&language=en-US";
    List<Results> popular = [];
    Response response = await dio.get(endPoint);
    if (response.statusCode == 200) {
      var body = response.data;
      // movies are called results in the api
      body["results"].forEach((movieData) {
        Results newSomething = Results.fromJson(movieData);
        popular.add(newSomething);
      });
    } else {
      throw Exception();
    }

    return popular;
  }

  Future<List<Reviews>> getReviews({
    required int id,
    required int pageNum,
  }) async {
    String endPoint =
        "https://api.themoviedb.org/3/tv/$id/reviews?api_key=$apiKey&language=en-US&page=$pageNum";
    List<Reviews> reviews = [];
    Response response = await dio.get(endPoint);
    if (response.statusCode == 200) {
      var body = response.data;
      // reviews are called results in the api
      body["results"].forEach((reviewData) {
        Reviews review = Reviews.fromJson(reviewData);
        reviews.add(review);
      });
    } else {
      throw Exception();
    }

    return reviews;
  }

  Future<Video> getVideos({required int id}) async {
    String endPoint =
        "https://api.themoviedb.org/3/tv/$id/videos?api_key=$apiKey&language=en-US";
    List<Video> videos = [];
    Response response = await dio.get(endPoint);
    if (response.statusCode == 200) {
      var body = response.data;
      body["results"].forEach((videoData) {
        Video aVideo = Video.fromJson(videoData);
        videos.add(aVideo);
      });
    } else {
      throw Exception();
    }
    Video trailer = videos.firstWhere(
      (element) => element.type == "Trailer",
      orElse: () => emptyVideo,
    );
    return trailer;
  }

  Future<List<TvShows>> searchShows({required String query}) async {
    String endPoint =
        "https://api.themoviedb.org/3/search/tv?api_key=$apiKey&language=en-US&query=$query";
    List<TvShows> tvShows = [];
    Response response = await dio.get(endPoint);
    if (response.statusCode == 200) {
      var body = response.data;
      // movies are called results in the api
      body["results"].forEach((movieData) {
        TvShows newShow = TvShows.fromJson(movieData);
        tvShows.add(newShow);
      });
    } else {
      throw Exception();
    }

    return tvShows;
  }

  Future<List<TvShows>> getGenre({
    required int page,
    required int genre,
  }) async {
    String endPoint =
        "https://api.themoviedb.org/3/discover/tv?api_key=$apiKey&language=en-US&sort_by=popularity.desc&page=$page&with_genres=$genre";
    List<TvShows> tvShows = [];
    Response response = await dio.get(endPoint);
    if (response.statusCode == 200) {
      var body = response.data;
      body["results"].forEach((showData) {
        TvShows newShow = TvShows.fromJson(showData);
        tvShows.add(newShow);
      });
    } else {
      throw Exception();
    }

    return tvShows;
  }
}
