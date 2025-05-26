import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_web/core/models/popular.dart';
import 'package:tmdb_web/private.dart';

// This is used to get the data from the rest api endpoint
class PopularService {
  Future<List<PopularItem>> getPopular() async {
    String endPoint =
        "https://api.themoviedb.org/3/trending/all/week?api_key=$apiKey";
    List<PopularItem> popular = [];
    Dio dio = GetIt.I.get<Dio>();
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
}
