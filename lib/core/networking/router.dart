import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_web/features/home_page.dart';
import 'package:tmdb_web/features/movies/movies_page.dart';
import 'package:tmdb_web/features/movies/movie_info.dart';
import 'package:tmdb_web/features/search_page.dart';
import 'package:tmdb_web/features/shows/main_page.dart';
import 'package:tmdb_web/features/shows/tv_page.dart';
import 'package:tmdb_web/features/shows/tv_info.dart';
import 'package:tmdb_web/features/movies/main_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      routes: [
        GoRoute(
          path: "movies",
          builder: (BuildContext context, GoRouterState state) =>
              const MainMovies(),
          routes: [
            GoRoute(
              path: "search",
              builder: (BuildContext context, GoRouterState state) =>
                  const SearchPage(movie: true),
            ),
            GoRoute(
              path: ":genre/:page",
              builder: (BuildContext context, GoRouterState state) =>
                  MoviesPage(
                    page: state.pathParameters['page']!,
                    category: state.pathParameters['genre']!,
                  ),
            ),
            GoRoute(
              path: ":id",
              builder: (BuildContext context, GoRouterState state) =>
                  MovieInfo(id: state.pathParameters['id']!),
            ),
          ],
        ),
        GoRoute(
          path: "tv",
          builder: (BuildContext context, GoRouterState state) =>
              const MainTv(),
          routes: [
            GoRoute(
              path: "search",
              builder: (BuildContext context, GoRouterState state) =>
                  const SearchPage(movie: false),
            ),
            GoRoute(
              path: ":genre/:page",
              builder: (BuildContext context, GoRouterState state) => TvPage(
                page: state.pathParameters['page']!,
                category: state.pathParameters['genre']!,
              ),
            ),
            GoRoute(
              path: ":id",
              builder: (BuildContext context, GoRouterState state) =>
                  TvInfo(id: state.pathParameters['id']!),
            ),
          ],
        ),
      ],
      path: "/",
      builder: (BuildContext context, GoRouterState state) => const HomePage(),
    ),
  ],
);
