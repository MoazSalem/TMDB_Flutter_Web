import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      onTap: () => context.go('/${title == "Movies" ? "movies" : "tv"}'),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 1.0.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "$title ",
              style: TextStyle(
                fontSize: 16.sp < 24 ? 24 : 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 7.sp),
              child: Icon(Icons.keyboard_double_arrow_right, size: 15.sp),
            ),
          ],
        ),
      ),
    );
  }
}
