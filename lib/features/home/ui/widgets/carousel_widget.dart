import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CarouselWidget extends StatelessWidget {
  final CarouselController controller;
  final void Function(int index)? onTap;
  final List<Widget> children;
  const CarouselWidget({
    super.key,
    required this.controller,
    required this.children,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: SizedBox(
        height: 100.w > 800 ? 50.h : 30.h,
        child: CarouselView.weighted(
          scrollDirection: Axis.horizontal,
          controller: controller,
          shrinkExtent: 800,
          onTap: (index) => onTap!(index),
          itemSnapping: true,
          flexWeights: [3, 2, 1],
          children: children,
        ),
      ),
    );
  }
}
