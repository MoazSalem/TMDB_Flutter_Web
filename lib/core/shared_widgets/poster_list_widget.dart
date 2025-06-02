import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tmdb_web/core/helpers/widgets_helper.dart';
import 'package:tmdb_web/core/shared_widgets/poster_details_widget.dart';
import 'package:tmdb_web/core/shared_widgets/image_widget.dart';

class PosterListWidget extends StatelessWidget {
  const PosterListWidget({super.key, required this.list});
  final List<dynamic> list;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      cacheExtent: 3500,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 2.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.6685,
        mainAxisSpacing: 1,
        crossAxisCount: WidgetsHelper.crossAxisCount(currentWidth: 100.w),
      ),
      itemCount: list.length,
      itemBuilder: (BuildContext context, index) {
        return InkWell(
          onTap: () => context.go(
            '/${list[index].title != null ? "movies" : "tv"}/${list[index].id}',
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              SizedBox(child: ImageWidget(item: list[index])),
              Container(
                alignment: Alignment.bottomLeft,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(160, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: PosterDetailsWidget(
                    item: list[index],
                    titleSize: 10.sp < 18 ? 18 : 10.sp,
                    ratingSize: 4.w > 16 ? 16 : 4.w,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
