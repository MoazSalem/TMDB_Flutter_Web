class Constants {
  static const String baseUrl = "https://api.themoviedb.org/3/";

  static const List<String> types = ["movie/", "tv/"];

  static List<Genre> moviesGenres = [
    Genre(name: "Action", id: '28'),
    Genre(name: "Adventure", id: '12'),
    Genre(name: "Animation", id: '16'),
    Genre(name: "Comedy", id: '35'),
    Genre(name: "Crime", id: '80'),
    Genre(name: "Documentary", id: '99'),
    Genre(name: "Drama", id: '18'),
    Genre(name: "Family", id: '10751'),
    Genre(name: "Fantasy", id: '14'),
    Genre(name: "History", id: '36'),
    Genre(name: "Horror", id: '27'),
    Genre(name: "Music", id: '10402'),
    Genre(name: "Mystery", id: '9648'),
    Genre(name: "Romance", id: '10749'),
    Genre(name: "Science Fiction", id: '878'),
    Genre(name: "TV Movie", id: '10770'),
    Genre(name: "Thriller", id: '53'),
    Genre(name: "War", id: '10752'),
    Genre(name: "Western", id: '37'),
  ];

  static List<Genre> tvGenres = [
    Genre(name: "Action & Adventure", id: '10759'),
    Genre(name: "Animation", id: '16'),
    Genre(name: "Comedy", id: '35'),
    Genre(name: "Crime", id: '80'),
    Genre(name: "Documentary", id: '99'),
    Genre(name: "Drama", id: '18'),
    Genre(name: "Family", id: '10751'),
    Genre(name: "Kids", id: '10762'),
    Genre(name: "Mystery", id: '9648'),
    Genre(name: "News", id: '10763'),
    Genre(name: "Reality", id: '10764'),
    Genre(name: "Sci-Fi & Fantasy", id: '10765'),
    Genre(name: "Soap", id: '10766'),
    Genre(name: "Talk", id: '10767'),
    Genre(name: "War & Politics", id: '10768'),
    Genre(name: "Western", id: '37'),
  ];

  // Lookup maps
  static final Map<String, String> moviesGenreMap = {
    for (final genre in moviesGenres) genre.name.toLowerCase(): genre.id,
  };

  static final Map<String, String> tvGenreMap = {
    for (final genre in tvGenres) genre.name.toLowerCase(): genre.id,
  };

  static const List<Category> movieCategories = [
    Category(apiKey: "popular", label: "Popular"),
    Category(apiKey: "top_rated", label: "Top Rated"),
    Category(apiKey: "now_playing", label: "Now Playing"),
    Category(apiKey: "upcoming", label: "Upcoming"),
  ];
  static const List<Category> tvCategories = [
    Category(apiKey: "popular", label: "Popular"),
    Category(apiKey: "top_rated", label: "Top Rated"),
    Category(apiKey: "airing_today", label: "Airing Today"),
    Category(apiKey: "on_the_air", label: "On The Air"),
  ];

  static const List<String> backdropSizes = [
    "w300",
    "w780",
    "w1280",
    "original",
  ];

  static const List<String> logoSizes = [
    "w45",
    "w92",
    "w154",
    "w185",
    "w300",
    "w500",
    "original",
  ];
  static const List<String> posterSizes = [
    "w92",
    "w154",
    "w185",
    "w342",
    "w500",
    "w780",
    "original",
  ];
  static const List<String> profileSizes = ["w45", "w185", "h632", "original"];
  static const List<String> stillSizes = ["w92", "w185", "w300", "original"];
}

class Category {
  final String apiKey;
  final String label;

  const Category({required this.apiKey, required this.label});
}

class Genre {
  final String id;
  final String name;

  const Genre({required this.id, required this.name});
}
