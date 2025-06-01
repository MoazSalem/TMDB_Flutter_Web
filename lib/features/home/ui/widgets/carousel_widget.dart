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
    return SizedBox(
      height: 100.w > 800 ? 50.h : 30.h,
      child: CarouselView.weighted(
        scrollDirection: Axis.horizontal,
        controller: controller,
        shrinkExtent: 800,
        onTap: (index) => popular[index].name == null
            ? context.go('/movies/${popular[index].id}')
            : context.go('/tv/${popular[index].id}'),
        itemSnapping: true,
        flexWeights: [3, 2, 1],
        children: List<Widget>.generate(
          popular.length,
          (index) => CarouselChildWidget(item: popular[index]),
        ),
      ),
    );
  }
}
