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
      height: 70.w > 400 ? 400 : 70.w,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) => InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          onTap: () => context.go('/$pageType/${list[index].id}'),
          child: FittedBox(
            child: SmallPosterWidget(index: index, suggestions: list),
          ),
        ),
      ),
    );
  }
}
