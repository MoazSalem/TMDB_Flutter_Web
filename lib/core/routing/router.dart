import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_web/features/categories/ui/categories.dart';
import 'package:tmdb_web/features/home/ui/home_page.dart';
import 'package:tmdb_web/features/home/logic/home_cubit.dart';
import 'package:tmdb_web/features/movie_tv_details/logic/movie_tv_details_cubit.dart';
import 'package:tmdb_web/features/movie_tv_details/ui/movie_tv_details.dart';
import 'package:tmdb_web/features/movies_tv_list/logic/movies_tv_list_cubit.dart';
import 'package:tmdb_web/features/movies_tv_list/ui/movies_tv_list.dart';
import 'package:tmdb_web/features/search/logic/search_cubit.dart';
import 'package:tmdb_web/features/search/ui/search_page.dart';

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
                      create: (context) => GetIt.I.get<MoviesTvListCubit>()
                        ..getMoviesOrTv(
                          type: state.pathParameters['type']!,
                          category: state.pathParameters['genre']!,
                          currentPage: int.parse(state.pathParameters['page']!),
                        ),
                      child: MoviesTvListPage(
                        key: ValueKey(state.pathParameters['genre']!),
                        pageType: state.pathParameters['page']!,
                      ),
                    ),
              ),
              GoRoute(
                path: ":id",
                builder: (BuildContext context, GoRouterState state) =>
                    BlocProvider(
                      create: (context) => MovieTvDetailsCubit()
                        ..getItem(
                          id: int.parse(state.pathParameters['id']!),
                          type: state.pathParameters['type']!,
                        ),
                      key: ValueKey(state.pathParameters['id']!),
                      child: MovieTvDetails(
                        key: ValueKey(state.pathParameters['id']!),
                        pageType: state.pathParameters['type']!,
                      ),
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
                      create: (context) => GetIt.I.get<MoviesTvListCubit>()
                        ..getMoviesOrTv(
                          type: state.pathParameters['type']!,
                          category: state.pathParameters['genre']!,
                          currentPage: int.parse(state.pathParameters['page']!),
                        ),
                      child: MoviesTvListPage(
                        key: ValueKey(state.pathParameters['page']!),
                        pageType: state.pathParameters['page']!,
                      ),
                    ),
              ),
              GoRoute(
                path: ":id",
                builder: (BuildContext context, GoRouterState state) =>
                    BlocProvider(
                      create: (context) => MovieTvDetailsCubit()
                        ..getItem(
                          id: int.parse(state.pathParameters['id']!),
                          type: state.pathParameters['type']!,
                        ),
                      key: ValueKey(state.pathParameters['id']!),
                      child: MovieTvDetails(
                        key: ValueKey(state.pathParameters['id']!),
                        pageType: state.pathParameters['type']!,
                      ),
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
