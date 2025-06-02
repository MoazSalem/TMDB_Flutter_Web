import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_web/core/shared_widgets/horizontal_poster_list_widget.dart';
import 'package:tmdb_web/core/shared_widgets/custom_app_bar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tmdb_web/features/home/logic/home_cubit.dart';
import 'package:tmdb_web/features/home/ui/widgets/carousel_widget.dart';
import 'package:tmdb_web/core/shared_widgets/title_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MediaQuery.sizeOf(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(showSearchIcon: false),
          body: state is HomeLoading
              ? const Center(child: CircularProgressIndicator())
              : state is HomeLoaded
              ? SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                    child: Column(
                      children: [
                        CarouselWidget(popular: state.popular),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleWidget(title: "Movies", url: '/movies'),
                            HorizontalPosterListWidget(
                              list: state.movies,
                              pageType: 'movies',
                            ),
                            TitleWidget(title: "Tv Shows", url: '/tv'),
                            HorizontalPosterListWidget(
                              list: state.tvShows,
                              pageType: 'tv',
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
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
