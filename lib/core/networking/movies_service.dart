import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_web/core/models/movie.dart';
import 'package:tmdb_web/core/models/videos.dart';
import 'package:tmdb_web/core/models/reviews.dart';
import 'package:tmdb_web/core/models/cast.dart';
import 'package:tmdb_web/core/models/popular.dart';
import 'package:tmdb_web/private.dart';

// This is used to get the data from the rest api endpoint
class MoviesService {
  Dio dio = GetIt.I.get<Dio>();
  Future<List<Movie>> getMovies({
    required int page,
    required String endPoint,
  }) async {
    endPoint += "$page";
    List<Movie> movies = [];
    Response response = await dio.get(endPoint);
    if (response.statusCode == 200) {
      var body = response.data;
      // movies are called results in the api
      body["results"].forEach((movieData) {
        Movie newMovie = Movie.fromJson(movieData);
        movies.add(newMovie);
      });
    } else {
      throw Exception();
    }

    return movies;
  }

  Future<Movie> getMovie({required int id}) async {
    String endPoint =
        "https://api.themoviedb.org/3/movie/$id?api_key=$apiKey&language=en-US";
    late Movie movie;
    Response response = await dio.get(endPoint);
    if (response.statusCode == 200) {
      var body = response.data;
      // movies are called results in the api
      movie = Movie.fromJson(body);
    } else {
      throw Exception();
    }
    return movie;
  }

  Future<List<Cast>> getCast({required int id}) async {
    String endPoint =
        "https://api.themoviedb.org/3/movie/$id/credits?api_key=$apiKey&language=en-US";
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

  Future<List<PopularItem>> getSuggestions({
    required int id,
    int type = 0,
  }) async {
    List<String> types = ["recommendations", "similar"];
    String endPoint =
        "https://api.themoviedb.org/3/movie/$id/${types[type]}?api_key=$apiKey&language=en-US";
    List<PopularItem> popular = [];
    Response response = await dio.get(endPoint);
    if (response.statusCode == 200) {
      var body = response.data;
      // movies are called results in the api
      body["results"].forEach((movieData) {
        PopularItem newSomething = PopularItem.fromJson(movieData);
        popular.add(newSomething);
      });
    } else {
      throw Exception();
    }

    return popular;
  }

  Future<List<Review>> getReviews({
    required int id,
    required int pageNum,
  }) async {
    String endPoint =
        "https://api.themoviedb.org/3/movie/$id/reviews?api_key=$apiKey&language=en-US&page=$pageNum";
    List<Review> reviews = [];
    Response response = await dio.get(endPoint);
    if (response.statusCode == 200) {
      var body = response.data;
      // reviews are called results in the api
      body["results"].forEach((reviewData) {
        Review review = Review.fromJson(reviewData);
        reviews.add(review);
      });
    } else {
      throw Exception();
    }

    return reviews;
  }

  Future<Video> getVideos({required int id}) async {
    String endPoint =
        "https://api.themoviedb.org/3/movie/$id/videos?api_key=$apiKey&language=en-US";
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

  Future<List<Movie>> searchMovies({required String query}) async {
    String endPoint =
        "https://api.themoviedb.org/3/search/movie?api_key=$apiKey&language=en-US&query=$query";
    List<Movie> movies = [];
    Response response = await dio.get(endPoint);
    if (response.statusCode == 200) {
      var body = response.data;
      // movies are called results in the api
      body["results"].forEach((movieData) {
        Movie newMovie = Movie.fromJson(movieData);
        movies.add(newMovie);
      });
    } else {
      throw Exception();
    }

    return movies;
  }

  Future<List<Movie>> getGenre({required int page, required int genre}) async {
    String endPoint =
        "https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&language=en-US&sort_by=popularity.desc&page=$page&with_genres=$genre";
    List<Movie> movies = [];
    Response response = await dio.get(endPoint);
    if (response.statusCode == 200) {
      var body = response.data;
      // movies are called results in the api
      body["results"].forEach((movieData) {
        Movie newMovie = Movie.fromJson(movieData);
        movies.add(newMovie);
      });
    } else {
      throw Exception();
    }

    return movies;
  }
}
