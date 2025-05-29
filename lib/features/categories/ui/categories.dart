import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tmdb_web/core/networking/constants.dart';
import 'package:tmdb_web/core/shared_widgets/categories_list_widget.dart';
import 'package:tmdb_web/core/shared_widgets/custom_app_bar.dart';
import 'package:tmdb_web/core/shared_widgets/title_widget.dart';

class Categories extends StatefulWidget {
  const Categories({super.key, required this.pageType});
  final String pageType;

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late double width;
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
    width = MediaQuery.sizeOf(context).width;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Colors.black,
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
                width: width,
              ),
              TitleWidget(title: "Genres", isClickable: false),
              CategoriesListWidget(
                pageType: widget.pageType,
                categories: genres,
                width: width,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
