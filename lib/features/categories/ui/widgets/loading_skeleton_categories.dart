import 'package:flutter/material.dart';
import 'package:tmdb_web/core/networking/constants.dart';
import 'package:tmdb_web/core/shared_widgets/skeleton_horizontal_poster_list_widget.dart';
import 'package:tmdb_web/core/shared_widgets/title_widget.dart';
import 'package:tmdb_web/features/categories/ui/widgets/categories_list_widget.dart';

class LoadingSkeletonCategories extends StatelessWidget {
  const LoadingSkeletonCategories({
    super.key,
    required this.categories,
    required this.genres,
    required this.pageType,
  });
  final List<Category> categories;
  final List<Genre> genres;
  final String pageType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWidget(
          title: categories[0].name,
          url: '/$pageType/${categories[0].apiKey}/1',
        ),
        SkeletonHorizontalPosterListWidget(),
        TitleWidget(
          title: categories[1].name,
          url: '/$pageType/${categories[1].apiKey}/1',
        ),
        SkeletonHorizontalPosterListWidget(),
        TitleWidget(
          title: categories[2].name,
          url: '/$pageType/${categories[2].apiKey}/1',
        ),
        SkeletonHorizontalPosterListWidget(),
        TitleWidget(
          title: categories[3].name,
          url: '/$pageType/${categories[3].apiKey}/1',
        ),
        SkeletonHorizontalPosterListWidget(),
        TitleWidget(title: "Genres"),
        CategoriesListWidget(pageType: pageType, categories: genres),
        SizedBox(height: 20),
      ],
    );
  }
}
