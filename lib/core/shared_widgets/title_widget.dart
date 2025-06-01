import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required this.title,
    this.isClickable = true,
    this.reducePadding = false,
  });
  final String title;
  final bool isClickable;
  final bool reducePadding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      onTap: isClickable
          ? () => context.go('/${title == "Movies" ? "movies" : "tv"}')
          : null,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 2.0.h,
          horizontal: reducePadding ? 0 : 1.0.w,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "$title ",
              style: TextStyle(
                fontSize: 16.sp < 20 ? 20 : 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (isClickable)
              Padding(
                padding: EdgeInsets.only(top: 6.sp),
                child: Icon(Icons.keyboard_double_arrow_right, size: 15.sp),
              ),
          ],
        ),
      ),
    );
  }
}
