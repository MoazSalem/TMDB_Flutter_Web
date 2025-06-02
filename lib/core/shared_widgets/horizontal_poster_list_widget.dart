import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_web/core/shared_widgets/poster_details_widget.dart';
import 'package:tmdb_web/core/shared_widgets/poster_image_widget.dart';

class HorizontalPosterListWidget extends StatelessWidget {
  const HorizontalPosterListWidget({
    super.key,
    required this.list,
    required this.pageType,
  });
  final dynamic list;
  final String pageType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 330,
      child: CarouselView(
        itemExtent: 220,
        shrinkExtent: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        scrollDirection: Axis.horizontal,
        controller: CarouselController(),
        onTap: (index) => context.go('/$pageType/${list[index].id}'),
        children: List<Widget>.generate(
          list.length,
          (index) => LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: PosterImageWidget(item: list[index]),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(160, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: constraints.maxWidth >= 160
                        ? PosterDetailsWidget(item: list[index])
                        : Container(),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
