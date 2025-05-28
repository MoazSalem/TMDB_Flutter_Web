import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
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
          crossAxisCount: crossAxisCount(currentWidth: 100.w),
        ),
        itemCount: list.length,
        itemBuilder: (BuildContext context, index) {
          return PosterWidget(item: list[index]);
        },
      ),
    );
  }
}

int crossAxisCount({required currentWidth}) {
  int count = currentWidth ~/ 250;
  count == 1
      ? count = 2
      : count > 5
      ? count = 5
      : count == 0
      ? count = 1
      : null;
  return count;
}
