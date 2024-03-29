class AllMovies {
  AllMovies({
    required this.page,
    required this.movies,
    required this.totalPages,
    required this.totalResults,
  });

  late final int page;
  late final List<Movie> movies;
  late final int totalPages;
  late final int totalResults;

  AllMovies.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    movies = List.from(json['results']).map((e) => Movie.fromJson(e)).toList();
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['page'] = page;
    data['results'] = movies.map((e) => e.toJson()).toList();
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    return data;
  }
}

class Movie {
  Movie({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.status,
    required this.releaseDate,
    required this.runtime,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  late final bool adult;
  late final String? backdropPath;
  late final List<Genres>? genres;
  late final List<dynamic>? genreIds;
  late final int id;
  late final String originalLanguage;
  late final String originalTitle;
  late final String overview;
  late final double popularity;
  late final String? posterPath;
  late final String? status;
  late final String releaseDate;
  late final int? runtime;
  late final String title;
  late final bool video;
  late final double voteAverage;
  late final int voteCount;

  Movie.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    genres = json['genres'] != null
        ? List.from(json['genres']).map((e) => Genres.fromJson(e)).toList()
        : null;
    genreIds = json['genre_ids'];
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    runtime = json['runtime'];
    status = json['status'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'].toDouble();
    voteCount = json['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['genres'] = genres?.map((e) => e.toJson()).toList();
    data['genre_ids'] = genreIds;
    data['id'] = id;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    data['release_date'] = releaseDate;
    data['runtime'] = runtime;
    data['status'] = status;
    data['title'] = title;
    data['video'] = video;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }
}

class Genres {
  Genres({
    required this.id,
    required this.name,
  });

  late final int id;
  late final String name;

  Genres.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

Movie emptyMovie = Movie(
    adult: false,
    backdropPath: "",
    genreIds: [],
    id: 0,
    originalLanguage: "",
    originalTitle: "",
    overview: "",
    popularity: 0,
    posterPath: "",
    releaseDate: "",
    title: "",
    video: false,
    voteAverage: 0,
    voteCount: 0,
    status: '',
    runtime: 0);
