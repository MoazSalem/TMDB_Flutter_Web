import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tmdb_web/core/shared_widgets/image_widget.dart';
import 'package:tmdb_web/features/movie_tv_details/ui/widgets/movie_title_info_widget.dart';

class TopCoverWidget extends StatelessWidget {
  const TopCoverWidget({super.key, this.item, required this.pageType});
  final dynamic item;
  final String pageType;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        SizedBox(
          width: double.infinity,
          height: 70.h > 500 ? 500 : 70.h,
          child: ImageWidget(item: item, isBackdrop: true, hd: true),
        ),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(140, 0, 0, 0),
                Color.fromARGB(0, 0, 0, 0),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          width: double.infinity,
          height: 40.h > 500 ? 500 : 40.h,
        ),
        MovieTitleInfoWidget(item: item, pageType: pageType),
      ],
    );
  }
}
