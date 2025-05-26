import 'package:tmdb_web/private.dart';

class Constants {
  static const String baseUrl = "https://api.themoviedb.org/3/";

  static List<String> types = ["movie", "tv"];

  static String getEndPoint({
    required int typeIndex,
    required String category,
  }) {
    return "$baseUrl${types[typeIndex]}/$category?api_key=$apiKey&language=en-US&page=";
  }

  static Map<String, int> categoriesMovies = {
    "action": 28,
    "adventure": 12,
    "animation": 16,
    "comedy": 35,
    "crime": 80,
    "documentary": 99,
    "drama": 18,
    "family": 10751,
    "fantasy": 14,
    "history": 36,
    "horror": 27,
    "music": 10402,
    "mystery": 9648,
    "romance": 10749,
    "science fiction": 878,
    "tv movie": 10770,
    "thriller": 53,
    "war": 10752,
    "western": 37,
  };

  static Map<String, int> categoriesTv = {
    "action & adventure": 10759,
    "animation": 16,
    "comedy": 35,
    "crime": 80,
    "documentary": 99,
    "drama": 18,
    "family": 10751,
    "kids": 10762,
    "mystery": 9648,
    "news": 10763,
    "reality": 10764,
    "sci-fi & fantasy": 10765,
    "soap": 10766,
    "talk": 10767,
    "war & politics": 10768,
    "western": 37,
  };
  static List<String> categoriesNamesTv = [
    "Action & Adventure",
    "Animation",
    "Comedy",
    "Crime",
    "Documentary",
    "Drama",
    "Family",
    "Kids",
    "Mystery",
    "News",
    "Sci-Fi & Fantasy",
    "Soap",
    "Talk",
    "War & Politics",
    "Western",
  ];

  static List<String> categoriesNamesMovies = [
    "Action",
    "Adventure",
    "Animation",
    "Comedy",
    "Crime",
    "Documentary",
    "Drama",
    "Family",
    "Fantasy",
    "History",
    "Horror",
    "Music",
    "Mystery",
    "Romance",
    "Science Fiction",
    "TV Movie",
    "Thriller",
    "War",
    "Western",
  ];
}
