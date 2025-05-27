import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_web/core/shared_widgets/list_widget.dart';
import 'package:tmdb_web/core/shared_widgets/app_bar.dart';
import 'package:tmdb_web/features/movies/movies_categories_list/logic/movies_categories_cubit.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  late double currentWidth;
  late ThemeData theme;
  final ScrollController scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentWidth = MediaQuery.of(context).size.width;
    theme = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesCategoriesCubit, MoviesCategoriesState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: theme.canvasColor,
          appBar: AppBar(
            centerTitle: true,
            toolbarHeight: 90,
            automaticallyImplyLeading: false,
            title: appBar(context: context),
            backgroundColor: theme.canvasColor,
          ),
          body: state is MoviesCategoriesLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Color(0xff8fcea2)),
                )
              : state is MoviesCategoriesLoaded
              ? ListView(
                  physics: const BouncingScrollPhysics(),
                  cacheExtent: 3500,
                  children: [
                    listWidget(
                      list: state.movies,
                      scrollController: scrollController,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Center(
                            child: Text("Page ${state.currentPage}"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                            right: 8.0,
                            top: 8.0,
                            bottom: 16.0,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  minimumSize: Size(currentWidth * 0.3, 60),
                                ),
                                onPressed: state.currentPage == 1
                                    ? null
                                    : () {
                                        context.go(
                                          "/movies/${state.category}/${1}",
                                        );
                                      },
                                child: Center(
                                  child: Icon(
                                    Icons.home_filled,
                                    color: state.currentPage == 1
                                        ? Colors.grey
                                        : const Color(0xff8fcea2),
                                  ),
                                ),
                              ),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  minimumSize: Size(currentWidth * 0.3, 60),
                                ),
                                onPressed: state.currentPage == 1
                                    ? null
                                    : () {
                                        context.push(
                                          "/movies/${state.category}/${state.currentPage - 1}",
                                        );
                                      },
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: state.currentPage == 1
                                        ? Colors.grey
                                        : const Color(0xff8fcea2),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: theme.primaryColor,
                                  minimumSize: Size(currentWidth * 0.3, 60),
                                ),
                                onPressed: () {
                                  context.push(
                                    "/movies/${state.category}/${state.currentPage + 1}",
                                  );
                                },
                                child: const Center(
                                  child: Icon(Icons.arrow_forward),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
