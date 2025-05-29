import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tmdb_web/core/networking/constants.dart';
import 'package:tmdb_web/core/shared_widgets/custom_app_bar.dart';

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
    width = MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Categories ",
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
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 20),
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: categories.length,
                cacheExtent: 20,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  crossAxisCount: width <= 700 ? 2 : 4,
                ),
                itemBuilder: (BuildContext context, index) => InkWell(
                  onTap: () {
                    context.go(
                      '/${widget.pageType.toLowerCase()}/${categories[index].apiKey}/1',
                    );
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor,
                    ),
                    width: 60,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                          child: Text(
                            categories[index].label,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 4.w > 30
                                  ? 100.w < 1200
                                        ? 20
                                        : 30
                                  : 100.w < 1200
                                  ? 20
                                  : 4.w,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Genres ",
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
            const SizedBox(height: 20),
            GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: genres.length,
              cacheExtent: 20,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                crossAxisCount: width <= 700 ? 3 : 4,
              ),
              itemBuilder: (BuildContext context, index) => InkWell(
                onTap: () {
                  context.go(
                    '/${widget.pageType.toLowerCase()}/${genres[index].name.toLowerCase()}/1',
                  );
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue.withOpacity(0.1),
                  ),
                  width: 60,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Text(
                          genres[index].name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 3.w > 25 ? 25 : 3.w,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
