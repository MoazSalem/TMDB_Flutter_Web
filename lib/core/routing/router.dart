import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_web/features/categories/movies_categories.dart';
import 'package:tmdb_web/features/home/ui/home_page.dart';
import 'package:tmdb_web/features/home/logic/home_cubit.dart';
import 'package:tmdb_web/features/movies/movie_detail/logic/movie_details_cubit.dart';
import 'package:tmdb_web/features/movies/movies_list/logic/movies_list_cubit.dart';
import 'package:tmdb_web/features/movies/movies_list/movies_list.dart';
import 'package:tmdb_web/features/movies/movie_detail/movie_details.dart';
import 'package:tmdb_web/features/search/logic/search_cubit.dart';
import 'package:tmdb_web/features/search/search_page.dart';
import 'package:tmdb_web/features/shows/show_detail/logic/show_details_cubit.dart';
import 'package:tmdb_web/features/shows/show_detail/show_detail.dart';
import 'package:tmdb_web/features/shows/shows_list/logic/shows_list_cubit.dart';
import 'package:tmdb_web/features/shows/shows_list/shows_list.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
        path: "/",
        builder: (BuildContext context, GoRouterState state) => BlocProvider(
          create: (context) => GetIt.I.get<HomeCubit>()..load(),
          child: const HomePage(),
        ),
        routes: <RouteBase>[
          GoRoute(
            path: ":type",
            builder: (BuildContext context, GoRouterState state) => Categories(
              key: ValueKey(state.pathParameters['type']!),
              pageType: state.pathParameters['type']!,
            ),
            routes: <RouteBase>[
              GoRoute(
                path: "search",
                builder: (BuildContext context, GoRouterState state) =>
                    BlocProvider(
                      create: (context) => SearchCubit(),
                      child: SearchPage(movie: true),
                    ),
              ),
              GoRoute(
                path: ":genre/:page",
                builder: (BuildContext context, GoRouterState state) =>
                    BlocProvider(
                      create: (context) => GetIt.I.get<MoviesListCubit>()
                        ..getMovies(
                          category: state.pathParameters['genre']!,
                          currentPage: int.parse(state.pathParameters['page']!),
                        ),
                      key: ValueKey(state.pathParameters['page']!),
                      child: MoviesListPage(),
                    ),
              ),
              GoRoute(
                path: ":id",
                builder: (BuildContext context, GoRouterState state) =>
                    BlocProvider(
                      create: (context) => MovieDetailsCubit()
                        ..getMovie(id: int.parse(state.pathParameters['id']!)),
                      key: ValueKey(state.pathParameters['id']!),
                      child: MovieInfo(),
                    ),
              ),
            ],
          ),
          GoRoute(
            path: ":type",
            builder: (BuildContext context, GoRouterState state) => Categories(
              key: ValueKey(state.pathParameters['type']!),
              pageType: state.pathParameters['type']!,
            ),
            routes: <RouteBase>[
              GoRoute(
                path: "search",
                builder: (BuildContext context, GoRouterState state) =>
                    BlocProvider(
                      create: (context) => SearchCubit(),
                      child: SearchPage(movie: false),
                    ),
              ),
              GoRoute(
                path: ":genre/:page",
                builder: (BuildContext context, GoRouterState state) =>
                    BlocProvider(
                      create: (context) => ShowsListCubit()
                        ..getShows(
                          category: state.pathParameters['genre']!,
                          currentPage: int.parse(state.pathParameters['page']!),
                        ),
                      key: ValueKey(state.pathParameters['page']!),
                      child: TvPage(),
                    ),
              ),
              GoRoute(
                path: ":id",
                builder: (BuildContext context, GoRouterState state) =>
                    BlocProvider(
                      create: (context) => ShowDetailsCubit()
                        ..getShow(id: int.parse(state.pathParameters['id']!)),
                      key: ValueKey(state.pathParameters['id']!),
                      child: ShowDetails(),
                    ),
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
