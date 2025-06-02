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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: SizedBox(
        height: 6.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(child: Text("Pages $currentPages")),
            ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: Size(20.w, 10)),
              onPressed: currentPages == "1-2"
                  ? null
                  : () {
                      context.go("/$pageType/$category/1-2");
                    },
              child: Center(
                child: Icon(
                  Icons.home_filled,
                  color: currentPages == "1-2"
                      ? Colors.grey
                      : const Color(0xff8fcea2),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: Size(20.w, 10)),
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
            FilledButton(
              style: FilledButton.styleFrom(
                foregroundColor: Colors.white,
                minimumSize: Size(20.w, 10),
              ),
              onPressed: () {
                context.go(
                  "/$pageType/$category/${"${int.parse(currentPages.split('-').first) + 2}-${int.parse(currentPages.split('-').last) + 2}"}",
                );
              },
              child: const Center(child: Icon(Icons.arrow_forward)),
            ),
          ],
        ),
      ),
    );
  }
}
