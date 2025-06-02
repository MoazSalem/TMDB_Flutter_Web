import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tmdb_web/core/networking/constants.dart';
import 'package:tmdb_web/core/shared_widgets/horizontal_list_widget.dart';
import 'package:tmdb_web/features/categories/logic/categories_cubit.dart';
import 'package:tmdb_web/features/categories/ui/widgets/categories_list_widget.dart';
import 'package:tmdb_web/core/shared_widgets/custom_app_bar.dart';
import 'package:tmdb_web/core/shared_widgets/title_widget.dart';

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
    widget.pageType == 'movies'
        ? {
            categories = Constants.movieCategories,
            genres = Constants.moviesGenres,
          }
        : {categories = Constants.tvCategories, genres = Constants.tvGenres};
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
                  ? const Center(child: CircularProgressIndicator())
                  : state is CategoriesLoaded
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleWidget(
                          title: categories[0].name,
                          url: '/${widget.pageType}/${categories[0].apiKey}/1',
                        ),
                        HorizontalListWidget(
                          list: state.firstCategoryList,
                          pageType: widget.pageType,
                        ),
                        TitleWidget(
                          title: categories[1].name,
                          url: '/${widget.pageType}/${categories[1].apiKey}/1',
                        ),
                        HorizontalListWidget(
                          list: state.secondCategoryList,
                          pageType: widget.pageType,
                        ),
                        TitleWidget(
                          title: categories[2].name,
                          url: '/${widget.pageType}/${categories[2].apiKey}/1',
                        ),
                        HorizontalListWidget(
                          list: state.thirdCategoryList,
                          pageType: widget.pageType,
                        ),
                        TitleWidget(
                          title: categories[3].name,
                          url: '/${widget.pageType}/${categories[3].apiKey}/1',
                        ),
                        HorizontalListWidget(
                          list: state.fourthCategoryList,
                          pageType: widget.pageType,
                        ),
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
