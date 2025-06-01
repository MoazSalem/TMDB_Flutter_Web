import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tmdb_web/core/shared_widgets/small_poster_widget.dart';

class HorizontalListWidget extends StatelessWidget {
  const HorizontalListWidget({
    super.key,
    required this.list,
    required this.pageType,
  });
  final dynamic list;
  final String pageType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 330,
      child: CarouselView(
        itemExtent: 220,
        shrinkExtent: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        scrollDirection: Axis.horizontal,
        controller: CarouselController(),
        onTap: (index) => context.go('/$pageType/${list[index].id}'),
        children: List<Widget>.generate(
          list.length,
          (index) => SmallPosterWidget(item: list[index]),
        ),
      ),
    );
  }
}
