import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tmdb_web/core/networking/constants.dart';
import 'package:tmdb_web/features/movie_tv_details/ui/widgets/categories_list_widget.dart';
import 'package:tmdb_web/core/shared_widgets/custom_app_bar.dart';
import 'package:tmdb_web/core/shared_widgets/title_widget.dart';

class Categories extends StatefulWidget {
  const Categories({super.key, required this.pageType});
  final String pageType;

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late final List<Category> categories;
  late final List<Genre> genres;

  @override
  void initState() {
    super.initState();
    categories = widget.pageType == 'movies'
        ? Constants.movieCategories
        : Constants.tvCategories;
    genres = widget.pageType == 'movies'
        ? Constants.moviesGenres
        : Constants.tvGenres;
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleWidget(title: "Categories", isClickable: false),
              CategoriesListWidget(
                pageType: widget.pageType,
                categories: categories,
              ),
              TitleWidget(title: "Genres", isClickable: false),
              CategoriesListWidget(
                pageType: widget.pageType,
                categories: genres,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
