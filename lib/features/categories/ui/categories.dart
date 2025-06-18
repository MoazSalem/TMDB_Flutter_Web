import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tmdb_web/core/networking/constants.dart';
import 'package:tmdb_web/core/shared_widgets/horizontal_poster_list_widget.dart';
import 'package:tmdb_web/features/categories/logic/categories_cubit.dart';
import 'package:tmdb_web/features/categories/ui/widgets/categories_list_widget.dart';
import 'package:tmdb_web/core/shared_widgets/custom_app_bar.dart';
import 'package:tmdb_web/core/shared_widgets/title_widget.dart';
import 'package:tmdb_web/features/categories/ui/widgets/loading_skeleton_categories.dart';

class Categories extends StatefulWidget {
  const Categories({super.key, required this.pageType});

  final String pageType;

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late final List<Genre> genres;
  late final List<Category> categories;

  @override
  void initState() {
    super.initState();
    if (widget.pageType == 'movies') {
      categories = Constants.movieCategories;
      genres = Constants.moviesGenres;
    } else {
      categories = Constants.tvCategories;
      genres = Constants.tvGenres;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MediaQuery.sizeOf(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: state is CategoriesLoading
                  ? LoadingSkeletonCategories(
                      pageType: widget.pageType,
                      categories: categories,
                      genres: genres,
                    )
                  : state is CategoriesLoaded
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var entry in state.categoryData.entries)
                          // Only build the section if the list for that category is not empty.
                          if (entry.value.isNotEmpty) ...[
                            TitleWidget(
                              title: entry.key.name,
                              url:
                                  '/${widget.pageType}/${entry.key.apiKey}/1-2',
                            ),
                            HorizontalPosterListWidget(
                              list: entry.value,
                              pageType: widget.pageType,
                            ),
                          ],
                        TitleWidget(title: "Genres"),
                        CategoriesListWidget(
                          pageType: widget.pageType,
                          categories: genres,
                        ),
                        SizedBox(height: 20),
                      ],
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }
}
