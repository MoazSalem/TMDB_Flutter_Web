import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_web/core/shared_widgets/suggestion_widget.dart';
import 'package:tmdb_web/core/shared_widgets/custom_app_bar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tmdb_web/features/home/logic/home_cubit.dart';
import 'package:tmdb_web/features/home/ui/widgets/carousel_child_widget.dart';
import 'package:tmdb_web/features/home/ui/widgets/carousel_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double width;
  final CarouselController _carouselController = CarouselController();

  // This is left to update the ui when the size changes
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    width = MediaQuery.of(context).size.width;
  }

  @override
  void dispose() {
    _carouselController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: CustomAppBar(showSearchIcon: false),
          body: state is HomeLoading
              ? const Center(child: CircularProgressIndicator())
              : state is HomeLoaded
              ? SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                    children: [
                      CarouselWidget(
                        controller: _carouselController,
                        onTap: (index) => state.popular[index].name == null
                            ? context.go('/movies/${state.popular[index].id}')
                            : context.go('/tv/${state.popular[index].id}'),
                        children: List<Widget>.generate(
                          state.popular.length,
                          (index) =>
                              CarouselChildWidget(item: state.popular[index]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(30),
                              ),
                              onTap: () => context.go('/movies'),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Movies ",
                                      style: TextStyle(
                                        fontSize: 5.w > 26 ? 26 : 5.w,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 4.w > 20 ? 20 : 4.w,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 20,
                              ),
                              child: SizedBox(
                                height: 70.w > 400 ? 400 : 70.w,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.movies.length,
                                  itemBuilder:
                                      (
                                        BuildContext context,
                                        int index,
                                      ) => InkWell(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(30),
                                        ),
                                        onTap: () => context.go(
                                          '/movies/${state.movies[index].id}',
                                        ),
                                        child: FittedBox(
                                          child: SuggestionWidget(
                                            index: index,
                                            suggestions: state.movies,
                                          ),
                                        ),
                                      ),
                                ),
                              ),
                            ),
                            InkWell(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(30),
                              ),
                              onTap: () => context.go('/tv'),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Tv Shows ",
                                      style: TextStyle(
                                        fontSize: 5.w > 26 ? 26 : 5.w,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 4.w > 20 ? 20 : 4.w,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 20,
                              ),
                              child: SizedBox(
                                height: 70.w > 400 ? 400 : 70.w,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.tvShows.length,
                                  itemBuilder:
                                      (BuildContext context, int index) =>
                                          InkWell(
                                            borderRadius:
                                                const BorderRadius.all(
                                                  Radius.circular(30),
                                                ),
                                            onTap: () => context.go(
                                              '/tv/${state.tvShows[index].id}',
                                            ),
                                            child: FittedBox(
                                              child: SuggestionWidget(
                                                index: index,
                                                suggestions: state.tvShows,
                                              ),
                                            ),
                                          ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
