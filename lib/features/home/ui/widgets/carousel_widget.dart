import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'carousel_child_widget.dart';

class CarouselWidget extends StatelessWidget {
  final CarouselController? controller;
  final List<dynamic> popular;
  const CarouselWidget({super.key, this.controller, required this.popular});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SizedBox(
        height: 70.h * Device.aspectRatio > 500
            ? 500
            : 70.h * Device.aspectRatio,
        child: CarouselView.weighted(
          scrollDirection: Axis.horizontal,
          controller: controller,
          shrinkExtent: 800,
          onTap: (index) => popular[index].name == null
              ? context.go('/movies/${popular[index].id}')
              : context.go('/tv/${popular[index].id}'),
          itemSnapping: true,
          flexWeights: 92.w > 900 ? [3, 2, 1] : [2, 1],
          children: List<Widget>.generate(
            popular.length,
            (index) => CarouselChildWidget(item: popular[index]),
          ),
        ),
      ),
    );
  }
}
