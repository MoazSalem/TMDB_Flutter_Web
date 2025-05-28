import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_web/core/shared_widgets/poster_list_widget.dart';
import 'package:tmdb_web/core/shared_widgets/app_bar.dart';
import 'package:tmdb_web/features/movies_tv_list/logic/movies_tv_list_cubit.dart';

class MoviesTvListPage extends StatefulWidget {
  const MoviesTvListPage({super.key, required this.pageType});

  final String pageType;

  @override
  State<MoviesTvListPage> createState() => _MoviesTvListPageState();
}

class _MoviesTvListPageState extends State<MoviesTvListPage> {
  late double currentWidth;
  final ScrollController scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentWidth = MediaQuery.of(context).size.width;
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesTvListCubit, MoviesTvListState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).canvasColor,
          appBar: AppBar(
            centerTitle: true,
            toolbarHeight: 90,
            automaticallyImplyLeading: false,
            title: CustomAppBar(),
            backgroundColor: Theme.of(context).canvasColor,
          ),
          body: state is MoviesTvListLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Color(0xff8fcea2)),
                )
              : state is MoviesTvListLoaded
              ? ListView(
                  physics: const BouncingScrollPhysics(),
                  cacheExtent: 3500,
                  children: [
                    PosterListWidget(
                      list: state.list,
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
                                          "/${widget.pageType}/${state.category}/1",
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
                                        context.go(
                                          "/${widget.pageType}/${state.category}/${state.currentPage - 1}",
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
                                  minimumSize: Size(currentWidth * 0.3, 60),
                                ),
                                onPressed: () {
                                  context.go(
                                    "/${widget.pageType}/${state.category}/${state.currentPage + 1}",
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
