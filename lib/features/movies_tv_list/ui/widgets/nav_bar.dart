import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
    required this.currentPages,
    required this.category,
    required this.pageType,
  });
  final String currentPages;
  final String category;
  final String pageType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 6.h < 50 ? 50 : 6.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder()),
              onPressed: () => context.go("/"),
              child: Center(
                child: Icon(Icons.home_filled, color: const Color(0xff8fcea2)),
              ),
            ),
          ),

          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder()),
              onPressed: currentPages == "1-2"
                  ? null
                  : () {
                      context.go(
                        "/$pageType/$category/${"${int.parse(currentPages.split('-').first) - 2}-${int.parse(currentPages.split('-').last) - 2}"}",
                      );
                    },
              child: Center(
                child: Icon(
                  Icons.arrow_back,
                  color: currentPages == "1-2"
                      ? Colors.grey
                      : const Color(0xff8fcea2),
                ),
              ),
            ),
          ),
          Expanded(
            child: FilledButton(
              style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder()),
              onPressed: () {
                context.go(
                  "/$pageType/$category/${"${int.parse(currentPages.split('-').first) + 2}-${int.parse(currentPages.split('-').last) + 2}"}",
                );
              },
              child: const Center(child: Icon(Icons.arrow_forward)),
            ),
          ),
        ],
      ),
    );
  }
}
