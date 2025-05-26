import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_web/features/home/home_page.dart';
import 'package:tmdb_web/features/home/logic/home_cubit.dart';
import 'package:tmdb_web/features/movies/movies_categories_list/movies_categories_list.dart';
import 'package:tmdb_web/features/movies/movie_detail/movie_details.dart';
import 'package:tmdb_web/features/search/search_page.dart';
import 'package:tmdb_web/features/shows/shows_categories/shows_categories.dart';
import 'package:tmdb_web/features/shows/shows_categories_list/shows_categories_list.dart';
import 'package:tmdb_web/features/shows/show_detail/show_detail.dart';
import 'package:tmdb_web/features/movies/movies_categories/movies_categories.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
        path: "/",
        builder: (BuildContext context, GoRouterState state) => BlocProvider(
          create: (context) => HomeCubit()..load(),
          child: const HomePage(),
        ),
        routes: <RouteBase>[
          GoRoute(
            path: "movies",
            builder: (BuildContext context, GoRouterState state) =>
                const MainMovies(),
            routes: <RouteBase>[
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
            routes: <RouteBase>[
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
      ),
    ],
    // Optional: Add an errorBuilder for unmatched routes
    errorBuilder: (BuildContext context, GoRouterState state) => Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(child: Text('Page not found: ${state.uri.path}')),
    ),
  );

  static GoRouter get router => _router;
}
