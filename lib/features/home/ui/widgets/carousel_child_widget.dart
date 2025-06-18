import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tmdb_web/core/shared_widgets/poster_details_widget.dart';
import 'package:tmdb_web/core/shared_widgets/image_widget.dart';

class CarouselChildWidget extends StatelessWidget {
  const CarouselChildWidget({super.key, required this.item});
  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: ImageWidget(item: item, type: "backdrop"),
        ),
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
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: PosterDetailsWidget(
              item: item,
              titleSize: 5.w > 30 ? 30 : 5.w,
              ratingSize: 4.w > 20 ? 20 : 4.w,
            ),
          ),
        ),
      ],
    );
  }
}
