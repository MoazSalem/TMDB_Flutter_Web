import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key, required this.title, this.url});
  final String title;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0.h),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        onTap: url == null ? null : () => context.go(url!),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "$title ",
              style: TextStyle(
                fontSize: 15.sp < 26 ? 26 : 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (url != null)
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
