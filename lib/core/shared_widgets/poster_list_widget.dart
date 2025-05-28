import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tmdb_web/core/helpers/widgets_helper.dart';
import 'package:tmdb_web/core/shared_widgets/poster_widget.dart';

class PosterListWidget extends StatelessWidget {
  const PosterListWidget({
    super.key,
    required this.list,
    required this.scrollController,
  });
  final List<dynamic> list;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: scrollController,
      thumbVisibility: true,
      child: GridView.builder(
        controller: scrollController,
        shrinkWrap: true,
        cacheExtent: 3500,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.6685,
          mainAxisSpacing: 1,
          crossAxisCount: WidgetsHelper.crossAxisCount(currentWidth: 100.w),
        ),
        itemCount: list.length,
        itemBuilder: (BuildContext context, index) {
          return PosterWidget(item: list[index]);
        },
      ),
    );
  }
}
