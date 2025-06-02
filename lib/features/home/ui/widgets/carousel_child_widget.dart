import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tmdb_web/core/shared_widgets/poster_details_widget.dart';
import 'package:tmdb_web/core/shared_widgets/image_widget.dart';

class CarouselChildWidget extends StatelessWidget {
  const CarouselChildWidget({super.key, required this.item});
  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          fit: StackFit.expand,
          children: [
            ImageWidget(item: item, isBackdrop: true),
            Container(
              alignment: Alignment.bottomLeft,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(150, 0, 0, 0),
                    Color.fromARGB(0, 0, 0, 0),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: constraints.maxWidth >= 30.w
                  ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: PosterDetailsWidget(
                        item: item,
                        titleSize: 4.w > 24 ? 24 : 4.w,
                        ratingSize: 3.w > 16 ? 16 : 3.w,
                      ),
                    )
                  : const SizedBox(),
            ),
          ],
        );
      },
    );
  }
}
