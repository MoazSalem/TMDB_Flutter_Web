import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tmdb_web/core/networking/constants.dart';

class CategoriesListWidget extends StatelessWidget {
  const CategoriesListWidget({
    super.key,
    required,
    required this.categories,
    required this.pageType,
  });
  final List<Genre> categories;
  final String pageType;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 3,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        crossAxisCount: (92.w / 180).floor().clamp(1, 8),
      ),
      itemBuilder: (BuildContext context, index) => InkWell(
        onTap: () {
          context.go('/$pageType/${categories[index].name.toLowerCase()}/1-2');
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.blueGrey, width: 2),
            color: Colors.transparent,
          ),
          width: 60,
          child: Center(
            child: FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  categories[index].name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp < 20 ? 20 : 13.sp,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
