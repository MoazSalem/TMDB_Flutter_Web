import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tmdb_web/core/shared_widgets/poster_list_widget.dart';
import 'package:tmdb_web/core/shared_widgets/custom_app_bar.dart';
import 'package:tmdb_web/features/movies_tv_list/logic/movies_tv_list_cubit.dart';
import 'package:tmdb_web/features/movies_tv_list/ui/widgets/loading_skeleton_movie_tv_list.dart';
import 'package:tmdb_web/features/movies_tv_list/ui/widgets/nav_bar.dart';

class MoviesTvListPage extends StatefulWidget {
  const MoviesTvListPage({super.key, required this.pageType});

  final String pageType;

  @override
  State<MoviesTvListPage> createState() => _MoviesTvListPageState();
}

class _MoviesTvListPageState extends State<MoviesTvListPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MediaQuery.sizeOf(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesTvListCubit, MoviesTvListState>(
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(),
          body: state is MoviesTvListLoading
              ? LoadingSkeletonMovieTvList()
              : state is MoviesTvListLoaded
              ? SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                    child: Column(
                      children: [
                        PosterListWidget(list: state.list),
                        NavBar(
                          pageType: widget.pageType,
                          category: state.category,
                          currentPages: state.currentPages,
                        ),
                      ],
                    ),
                  ),
                )
              : null,
        );
      },
    );
  }
}
