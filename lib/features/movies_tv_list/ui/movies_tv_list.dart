import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tmdb_web/core/shared_widgets/poster_list_widget.dart';
import 'package:tmdb_web/core/shared_widgets/custom_app_bar.dart';
import 'package:tmdb_web/features/movies_tv_list/logic/movies_tv_list_cubit.dart';
import 'package:tmdb_web/features/movies_tv_list/ui/widgets/nav_bar.dart';

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
    currentWidth = MediaQuery.sizeOf(context).width;
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
          appBar: CustomAppBar(),
          body: state is MoviesTvListLoading
              ? const Center(child: CircularProgressIndicator())
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
                          currentPage: state.currentPage,
                        ),
                      ],
                    ),
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
