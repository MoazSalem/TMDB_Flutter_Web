import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_web/core/shared_widgets/list_widget.dart';
import 'package:tmdb_web/core/shared_widgets/app_bar.dart';
import 'package:tmdb_web/features/shows/shows_list/logic/shows_list_cubit.dart';

class TvPage extends StatefulWidget {
  const TvPage({super.key});

  @override
  State<TvPage> createState() => _TvPageState();
}

class _TvPageState extends State<TvPage> {
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
    return BlocBuilder<ShowsListCubit, ShowsListState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: theme.canvasColor,
          appBar: AppBar(
            centerTitle: true,
            toolbarHeight: 90,
            automaticallyImplyLeading: false,
            title: appBar(context: context, movie: false),
            backgroundColor: theme.canvasColor,
          ),
          body: state is ShowsListLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Color(0xff09b5e1)),
                )
              : state is ShowsListLoaded
              ? ListView(
                  physics: const BouncingScrollPhysics(),
                  cacheExtent: 3500,
                  children: [
                    listWidget(
                      list: state.shows,
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
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  minimumSize: Size(currentWidth * 0.3, 50),
                                ),
                                onPressed: state.currentPage == 1
                                    ? null
                                    : () async {
                                        context.go("/tv/${state.category}/1");
                                      },
                                child: Icon(
                                  Icons.home_filled,
                                  color: state.currentPage == 1
                                      ? Colors.grey
                                      : const Color(0xff8fcea2),
                                ),
                              ),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  minimumSize: Size(currentWidth * 0.3, 50),
                                ),
                                onPressed: state.currentPage == 1
                                    ? null
                                    : () async {
                                        context.go(
                                          "/tv/${state.category}/${state.currentPage - 1}",
                                        );
                                      },
                                child: Icon(
                                  Icons.arrow_back,
                                  color: state.currentPage == 1
                                      ? Colors.grey
                                      : const Color(0xff8fcea2),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: theme.primaryColor,
                                  minimumSize: Size(currentWidth * 0.3, 50),
                                ),
                                onPressed: () async {
                                  context.go(
                                    "/tv/${state.category}/${state.currentPage + 1}",
                                  );
                                },
                                child: const Icon(Icons.arrow_forward),
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
