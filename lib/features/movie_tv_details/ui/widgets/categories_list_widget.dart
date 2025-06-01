import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CategoriesListWidget extends StatelessWidget {
  const CategoriesListWidget({
    super.key,
    required,
    required this.categories,
    required this.pageType,
  });
  final List categories;
  final String pageType;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 4,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        crossAxisCount: Device.orientation == Orientation.portrait ? 2 : 4,
      ),
      itemBuilder: (BuildContext context, index) => InkWell(
        onTap: () {
          context.go(
            '/${pageType.toLowerCase()}/${categories[index].apiKey}/1',
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blueGrey,
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
